//ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'device.dart';
import 'testing_tools.dart';
import 'widget_tester_extension_sec.dart';

Future<void> _twoPumps(Device device, WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

/// Function definition for allowing for device or test setup to occur for each device configuration under test
typedef DeviceSetup = Future<void> Function(Device device, WidgetTester tester);

/// This multiScreenGolden will run scenarios for given [devices] list
///
/// Will output a single  golden file for each device in [devices] and will append device name to png file
///
/// [name] is a file name output, must NOT include extension like .png
///
/// [autoHeight] tries to find the optimal height for the output surface. If there is a vertical scrollable this
/// ensures the whole scrollable is shown. If the targeted render box is smaller then the current height, this will
/// shrink down the output height to match the render boxes height.
///
/// [finder] optional finder, defaults to [WidgetsApp]
///
/// [overrideGoldenHeight] might be required to override output file height in case if it should be bigger than device height
///
/// [customPump] optional pump function, see [CustomPump] documentation
///
/// [deviceSetup] allows custom setup after the window changes size.
/// Takes two pumps to modify the device size. It could take more if the widget tree uses widgets that schedule builds for the next run loop
/// e.g. StreamBuilder, FutureBuilder
///
/// [devices] list of devices to run the tests
///
/// [skip] by setting to true will skip the golden file assertion. This may be necessary if your development platform is not the same as your CI platform
///
Future<void> multiScreenGolden2(
  WidgetTester tester,
  String name, {
  required List<Device> devices,
  Finder? finder,
  bool? autoHeight,
  double? overrideGoldenHeight,
  CustomPump? customPump,
  DeviceSetup? deviceSetup,
  @Deprecated(
    'This method level parameter will be removed in an upcoming release. This can be configured globally. If you have concerns, please file an issue with your use case.',
  )
  bool? skip,
}) async {
  assert(devices.isNotEmpty);
  final deviceSetupPump = deviceSetup ?? _twoPumps;
  for (final device in devices) {
    await tester.view.runWithDeviceOverrides(
      device: device,
      binding: tester.binding,
      body: () async {
        if (overrideGoldenHeight != null) {
          await tester.binding.setSurfaceSize(
            Size(device.size.width, overrideGoldenHeight),
          );
        }
        await deviceSetupPump(device, tester);
        await compareWithGolden2(
          tester,
          name,
          customPump: customPump,
          autoHeight: autoHeight,
          finder: finder,
          skip: skip,
          device: device,
        );
      },
    );
  }
}
