import 'package:flutter_test/flutter_test.dart';

import 'device.dart';
import 'multi_screen_golden.dart';
import 'testing_tools.dart';

Future<void> multiScreenGoldenWithPump(
  WidgetTester tester,
  String name, {
  bool? autoHeight,
}) {
  return appMultiScreenGolden(
    tester,
    name,
    customPump: (tester) async {
      // Due to infinite animation
      await tester.pump();
    },
    autoHeight: autoHeight,
  );
}

Future<void> appMultiScreenGolden(
  WidgetTester tester,
  String name, {
  Finder? finder,
  bool? autoHeight,
  double? overrideGoldenHeight,
  CustomPump? customPump,
  List<Device>? devices,
}) async {
  return multiScreenGolden2(
    tester,
    name,
    finder: finder,
    autoHeight: autoHeight,
    overrideGoldenHeight: overrideGoldenHeight,
    customPump: customPump,
    devices:
        devices ??
        [
          Device.phone,
          Device.tabletLandscape,
          // Device.phone.copyWith(
          //   brightness: Brightness.dark,
          //   name: 'phone_dark',
          // ),
        ],
  );
}
