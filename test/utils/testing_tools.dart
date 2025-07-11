import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'device.dart';
import 'test_asset_bundle.dart';

const Size _defaultSize = Size(800, 600);

///CustomPump is a function that lets you do custom pumping before golden evaluation.
///Sometimes, you want to do a golden test for different stages of animations, so its crucial to have a precise control over pumps and durations
typedef CustomPump = Future<void> Function(WidgetTester);

/// Typedef for wrapping a widget with one or more other widgets
typedef WidgetWrapper = Widget Function(Widget);

/// Hook for running arbitrary behavior for a particular scenario
typedef OnScenarioCreate = Future<void> Function(Key scenarioWidgetKey);

bool _inGoldenTest = false;

/// Extensions for a [WidgetTester]
extension TestingToolsExtension on WidgetTester {
  /// Extension for a [WidgetTester] that pumps the widget and provides an optional [WidgetWrapper]
  ///
  /// [WidgetWrapper] defaults to [materialAppWrapper]
  ///
  /// [surfaceSize] set's the surface size, defaults to [_defaultSize]
  ///
  /// [textScaleSize] set's the text scale size (usually in a range from 1 to 3)
  Future<void> pumpWidgetBuilder(
    Widget widget, {
    WidgetWrapper? wrapper,
    Size surfaceSize = _defaultSize,
    double textScaleSize = 1.0,
  }) async {
    final wrap = wrapper ?? materialAppWrapper();

    await _pumpAppWidget(
      this,
      wrap(widget),
      surfaceSize: surfaceSize,
      textScaleSize: textScaleSize,
    );
  }
}

/// This [materialAppWrapper] is a convenience function to wrap your widget in [MaterialApp]
/// Wraps your widget in MaterialApp, inject  custom theme, localizations, override  surfaceSize and platform
///
/// [platform] will override Theme's platform. [theme] is required
///
/// [localizations] is list of [LocalizationsDelegate] that is required for this test
///
/// [navigatorObserver] is an interface for observing the behavior of a [Navigator].
///
/// [localeOverrides] will set supported supportedLocales, defaults to [Locale('en')]
///
/// [theme] Your app theme
WidgetWrapper materialAppWrapper({
  TargetPlatform platform = TargetPlatform.android,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
  NavigatorObserver? navigatorObserver,
  Iterable<Locale>? localeOverrides,
  ThemeData? theme,
}) {
  return (child) => MaterialApp(
    localizationsDelegates: localizations,
    supportedLocales: localeOverrides ?? const [Locale('en')],
    theme: theme?.copyWith(platform: platform),
    debugShowCheckedModeBanner: false,
    home: Material(child: child),
    navigatorObservers: [if (navigatorObserver != null) navigatorObserver],
  );
}

/// This [noWrap] is a convenience function if you don't want to wrap widgets in default [materialAppWrapper]
WidgetWrapper noWrap() =>
    (child) => child;

Future<void> _pumpAppWidget(
  WidgetTester tester,
  Widget app, {
  required Size surfaceSize,
  required double textScaleSize,
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  tester.view.physicalSize = surfaceSize;
  tester.view.devicePixelRatio = 1.0;
  tester.platformDispatcher.textScaleFactorTestValue = textScaleSize;

  await tester.pumpWidget(
    DefaultAssetBundle(bundle: TestAssetBundle(), child: app),
  );
  await tester.pump();
}

/// This [testGoldens] method exists as a way to enforce the proper naming of tests that contain golden diffs so that we can reliably run all goldens
///
/// [description] is a test description
///
/// [skip] to skip the test
///
/// [test] test body
///
@isTest
void testGoldens(
  String description,
  Future<void> Function(WidgetTester) test, {
  bool? skip,
}) {
  // final dynamic config = Zone.current[#goldentoolkit.config];
  testWidgets(
    description,
    (tester) async {
      Future<void> body() async {
        _inGoldenTest = true;
        final initialDebugDisableShadowsValue = debugDisableShadows;
        final shouldUseRealShadows = false;
        //GoldenToolkit.configuration.enableRealShadows;
        debugDisableShadows = !shouldUseRealShadows;
        try {
          await test(tester);
        } finally {
          debugDisableShadows = initialDebugDisableShadowsValue;
          _inGoldenTest = false;
        }
      }

      await body();
    },
    skip: skip,
    tags: const ['golden'],
  );
}

Future<void> compareWithGolden2(
  WidgetTester tester,
  String name, {
  required Device device,
  bool? autoHeight,
  Finder? finder,
  CustomPump? customPump,
  bool? skip,
}) async {
  assert(!name.endsWith('.png'), 'Golden tests should not include file type');
  if (!_inGoldenTest) {
    fail(
      'Golden tests MUST be run within a testGoldens method, not just a testWidgets method. This is so we can be confident that running "flutter test --name=GOLDEN" will run all golden tests.',
    );
  }

  final pumpAfterPrime = customPump ?? _onlyPumpAndSettle;
  /* if no finder is specified, use the first widget. Note, there is no guarantee this evaluates top-down, but in theory if all widgets are in the same
  RepaintBoundary, it should not matter */
  final actualFinder = finder ?? find.byWidgetPredicate((w) => true).first;
  final originalWindowSize = tester.view.physicalSize;

  await defaultPrimeAssets(tester);

  await pumpAfterPrime(tester);

  if (autoHeight ?? false) {
    // Find the first scrollable element which can be scrolled vertical.
    // ListView, SingleChildScrollView, CustomScrollView? are implemented using a Scrollable widget.
    final scrollable = find
        .byType(Scrollable)
        .evaluate()
        .map<ScrollableState?>((element) {
          if (element is StatefulElement) {
            final state = element.state;
            if (state is ScrollableState) {
              return state;
            }
          }
          return null;
        })
        .firstWhere((state) {
          final position = state?.position;
          return position?.axisDirection == AxisDirection.down;
        }, orElse: () => null);

    final renderObject = tester.renderObject(actualFinder);

    var finalHeight = originalWindowSize.height;
    if (scrollable != null && scrollable.position.extentAfter.isFinite) {
      finalHeight = originalWindowSize.height + scrollable.position.extentAfter;
    } else if (renderObject is RenderBox) {
      finalHeight = renderObject.size.height;
    }

    final adjustedSize = Size(originalWindowSize.width, finalHeight);
    await tester.binding.setSurfaceSize(adjustedSize);
    tester.view.physicalSize = adjustedSize;

    await tester.pump();
  }

  await expectLater(
    finder ?? find.byWidgetPredicate((w) => true).first,
    matchesGoldenFile('goldens/$name.${device.name}.png'),
  );

  if (autoHeight ?? false) {
    // Here we reset the window size to its original value to be clean
    await tester.binding.setSurfaceSize(originalWindowSize);
    tester.view.physicalSize = originalWindowSize;
  }
}

Future<void> _onlyPumpAndSettle(WidgetTester tester) async =>
    tester.pumpAndSettle();

/// A function that waits for all [Image] widgets found in the widget tree to finish decoding.
///
/// Currently this supports images included via Image widgets, or as part of BoxDecorations.
///
Future<void> defaultPrimeAssets(WidgetTester tester) async {
  final imageElements = find.byType(Image, skipOffstage: false).evaluate();
  final containerElements = find
      .byType(DecoratedBox, skipOffstage: false)
      .evaluate();
  await tester.runAsync(() async {
    for (final imageElement in imageElements) {
      final widget = imageElement.widget;
      if (widget is Image) {
        await precacheImage(widget.image, imageElement);
      }
    }
    for (final container in containerElements) {
      final widget = container.widget as DecoratedBox;
      final decoration = widget.decoration;
      if (decoration is BoxDecoration) {
        if (decoration.image != null) {
          await precacheImage(decoration.image!.image, container);
        }
      }
    }
  });
}
