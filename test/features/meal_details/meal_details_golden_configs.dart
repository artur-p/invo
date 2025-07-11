import 'package:flutter_test/flutter_test.dart';

import '../../utils/golden_utils.dart';
import '../../utils/testing_tools.dart';

const testNamePrefix = 'MealDetails';

void mealDetailsGoldenPageTest(
  int testNumber, {
  required Future<List<String>> Function(WidgetTester tester) testSteps,
  String? additionalDescription,
}) {
  testGoldens('$testNamePrefix $testNumber', (tester) async {
    final testStepsResult = await testSteps(tester);

    await appMultiScreenGolden(
      tester,
      '$testNamePrefix$testNumber${testStepsResult.join()}${additionalDescription ?? ''}',
      autoHeight: true,
    );
  });
}
