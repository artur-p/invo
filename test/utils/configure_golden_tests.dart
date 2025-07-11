import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invo_app/constants/fonts.gen.dart';

import 'golden_file_comparator_fork.dart';

const _goldenTestsThreshold = 0.0002;

Future<void> configureGoldenTests() async {
  await _loadAppFonts();

  final imageDiffs = Platform.environment['GOLDEN_TESTS_IMAGE_DIFFS'];
  await _setComparator(imageDiffs != 'FALSE');
}

Future<void> _loadAppFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fontLoader = FontLoader(FontFamily.interDisplay)
    ..addFont(
      rootBundle.load('lib/app/foundations/fonts/InterDisplay-Black.ttf'),
    )
    ..addFont(
      rootBundle.load('lib/app/foundations/fonts/InterDisplay-Bold.ttf'),
    )
    ..addFont(
      rootBundle.load('lib/app/foundations/fonts/InterDisplay-ExtraBold.ttf'),
    )
    ..addFont(
      rootBundle.load('lib/app/foundations/fonts/InterDisplay-Italic.ttf'),
    )
    ..addFont(
      rootBundle.load('lib/app/foundations/fonts/InterDisplay-Light.ttf'),
    );

  await fontLoader.load();
}

Future<void> _setComparator(bool imageDiffs) async {
  if (goldenFileComparator is LocalFileComparator) {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    goldenFileComparator = _LocalFileComparatorWithThreshold(
      Uri.parse('$testUrl/test.dart'),
      threshold: _goldenTestsThreshold,
      imageDiffs: imageDiffs,
    );
  } else {
    throw Exception(
      'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
      'but it is of type `${goldenFileComparator.runtimeType}`',
    );
  }
}

class _LocalFileComparatorWithThreshold extends LocalFileComparator {
  _LocalFileComparatorWithThreshold(
    super.testFile, {
    required this.threshold,
    required this.imageDiffs,
  }) : assert(threshold >= 0 && threshold <= 1);

  final double threshold;
  final bool imageDiffs;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await compareListsFork(
      imageBytes,
      await getGoldenBytes(golden),
      imageDiffs: imageDiffs,
    );

    if (!result.passed && result.diffPercent <= threshold) {
      debugPrint(
        'A difference of ${result.diffPercent * 100}% was found, but it is '
        'acceptable since it is not greater than the threshold of '
        '${threshold * 100}%',
      );

      return true;
    }

    if (!result.passed) {
      final error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    return result.passed;
  }
}
