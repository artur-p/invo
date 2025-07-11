import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/app/foundations/theme/theme_mode.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'device.dart';

extension AppWidgetTesterExtension on WidgetTester {
  Future<void> pumpAppWidget(
    WidgetBuilder builder, {
    bool inverted = false,
    bool scrollsBehindTopBar = false,
    List<SingleChildWidget> providers = const <SingleChildWidget>[],
  }) {
    return pumpWidget(
      MultiProvider(
        providers: [
          Provider<InvoThemeMode>(create: (context) => InvoThemeMode.standard),
          ...providers,
        ],
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('pl', 'PL'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                return Scaffold(
                  body: Container(
                    color: context.colors.background,
                    padding: EdgeInsets.all(InvoSpaces.space16),
                    child: builder(context),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Convenience extensions for more easily configuring WidgetTester for pre-set configurations
extension WidgetFlutterBindingExtensions on TestFlutterView {
  /// Configure the Test device for the duration of the supplied operation and revert
  ///
  /// [device] the desired configuration to apply
  ///
  /// [body] the closure you wish to be executed with the device configuration applied
  ///
  Future<void> runWithDeviceOverrides({
    required Device device,
    required TestWidgetsFlutterBinding binding,
    required Future<void> Function() body,
  }) async {
    await applyDeviceOverrides(device: device, binding: binding);
    try {
      await body();
    } finally {
      await resetDeviceOverrides(binding);
    }
  }

  /// Configure the Test device to match the configuration of the supplied device
  ///
  /// Note: these settings will persist across multiple tests in the same file. It is recommended
  /// that you reset upon completion.
  ///
  /// [device] the desired configuration to apply
  ///
  Future<void> applyDeviceOverrides({
    required Device device,
    required TestWidgetsFlutterBinding binding,
  }) async {
    await binding.setSurfaceSize(Size(device.size.width, device.size.height));

    physicalSize = device.size * device.devicePixelRatio;
    devicePixelRatio = device.devicePixelRatio;
    platformDispatcher
      ..textScaleFactorTestValue = device.textScale
      ..platformBrightnessTestValue = device.brightness;
    safeAreaTestValue = device.safeArea;
  }

  /// Resets any configuration that may be been specified by applyDeviceOverrides
  ///
  /// Only needs to be called if you are concerned about the result of applyDeviceOverrides bleeding over across tests.
  Future<void> resetDeviceOverrides(TestWidgetsFlutterBinding binding) async {
    // there is an untested assumption that clearing these specific values is cheaper than
    // calling binding.window.clearAllTestValues().
    resetDevicePixelRatio();
    platformDispatcher.clearPlatformBrightnessTestValue();
    resetPadding();
    platformDispatcher.clearTextScaleFactorTestValue();
    resetPhysicalSize();
    await binding.setSurfaceSize(null);
  }
}

/// Convenience extensions for configuring elements of the TestWindow
extension TestWindowExtensions on TestFlutterView {
  /// convenience wrapper for configuring the paddingTestValue
  ///
  /// paddingTestValue requires you creating your own class that implements WindowPadding
  ///
  /// [safeArea] specifies the safe area insets for all 4 edges that you wish to simulate
  ///
  set safeAreaTestValue(EdgeInsets safeArea) {
    padding = _FakeWindowPadding(
      bottom: safeArea.bottom,
      left: safeArea.left,
      right: safeArea.right,
      top: safeArea.top,
    );
  }
}

class _FakeWindowPadding implements FakeViewPadding {
  const _FakeWindowPadding({
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
    this.top = 0,
  });

  @override
  final double bottom;

  @override
  final double left;

  @override
  final double right;

  @override
  final double top;
}
