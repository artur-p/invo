// ignore_for_file: prefer_int_literals, require_trailing_commas, omit_local_variable_types, cascade_invocations

import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

Future<ComparisonResult> compareListsFork(
  List<int>? test,
  List<int>? master, {
  int diffPixelThreshold = 3,
  required bool imageDiffs,
}) async {
  if (identical(test, master)) {
    return ComparisonResult(passed: true, diffPercent: 0.0);
  }

  if (test == null || master == null || test.isEmpty || master.isEmpty) {
    return ComparisonResult(
      passed: false,
      diffPercent: 1.0,
      error: 'Pixel test failed, null image provided.',
    );
  }

  final Codec testImageCodec = await instantiateImageCodec(
    Uint8List.fromList(test),
  );
  final Image testImage = (await testImageCodec.getNextFrame()).image;
  final ByteData? testImageRgba = await testImage.toByteData();

  final Codec masterImageCodec = await instantiateImageCodec(
    Uint8List.fromList(master),
  );
  final Image masterImage = (await masterImageCodec.getNextFrame()).image;
  final ByteData? masterImageRgba = await masterImage.toByteData();

  final int width = testImage.width;
  final int height = testImage.height;

  if (width != masterImage.width || height != masterImage.height) {
    return ComparisonResult(
      passed: false,
      diffPercent: 1.0,
      error:
          'Pixel test failed, image sizes do not match.\n'
          'Master Image: ${masterImage.width} X ${masterImage.height}\n'
          'Test Image: ${testImage.width} X ${testImage.height}',
    );
  }

  int pixelDiffCount = 0;
  final int totalPixels = width * height;
  final ByteData invertedMasterRgba = _invert(masterImageRgba!);
  final ByteData invertedTestRgba = _invert(testImageRgba!);

  final Uint8List testImageBytes = (await testImage.toByteData())!.buffer
      .asUint8List();

  ByteData? maskedDiffRgba;
  ByteData? isolatedDiffRgba;

  if (imageDiffs) {
    maskedDiffRgba = ByteData(testImageBytes.length);
    maskedDiffRgba.buffer.asUint8List().setRange(
      0,
      testImageBytes.length,
      testImageBytes,
    );
    isolatedDiffRgba = ByteData(width * height * 4);
  }

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      final int byteOffset = (width * y + x) * 4;
      final int testPixel = testImageRgba.getUint32(byteOffset);
      final int masterPixel = masterImageRgba.getUint32(byteOffset);

      final int diffPixel =
          (_readRed(testPixel) - _readRed(masterPixel)).abs() +
          (_readGreen(testPixel) - _readGreen(masterPixel)).abs() +
          (_readBlue(testPixel) - _readBlue(masterPixel)).abs() +
          (_readAlpha(testPixel) - _readAlpha(masterPixel)).abs();

      if (diffPixel > diffPixelThreshold) {
        if (imageDiffs) {
          final int invertedMasterPixel = invertedMasterRgba.getUint32(
            byteOffset,
          );
          final int invertedTestPixel = invertedTestRgba.getUint32(byteOffset);
          // We grab the max of the 0xAABBGGRR encoded bytes, and then convert
          // back to 0xRRGGBBAA for the actual pixel value, since this is how it
          // was historically done.
          final int maskPixel = _toRGBA(
            math.max(_toABGR(invertedMasterPixel), _toABGR(invertedTestPixel)),
          );
          maskedDiffRgba!.setUint32(byteOffset, maskPixel);
          isolatedDiffRgba!.setUint32(byteOffset, maskPixel);
        }
        pixelDiffCount++;
      }
    }
  }

  if (pixelDiffCount > 0) {
    final double diffPercent = pixelDiffCount / totalPixels;
    return ComparisonResult(
      passed: false,
      diffPercent: diffPercent,
      error:
          'Pixel test failed, '
          '${(diffPercent * 100).toStringAsFixed(2)}% '
          'diff detected.',
      diffs: imageDiffs
          ? <String, Image>{
              'masterImage': masterImage,
              'testImage': testImage,
              'maskedDiff': await _createImage(maskedDiffRgba!, width, height),
              'isolatedDiff': await _createImage(
                isolatedDiffRgba!,
                width,
                height,
              ),
            }
          : null,
    );
  }
  return ComparisonResult(passed: true, diffPercent: 0.0);
}

/// Inverts [imageBytes], returning a new [ByteData] object.
ByteData _invert(ByteData imageBytes) {
  final ByteData bytes = ByteData(imageBytes.lengthInBytes);
  // Invert the RGB data (but not A).
  for (int i = 0; i < imageBytes.lengthInBytes; i += 4) {
    bytes.setUint8(i, 255 - imageBytes.getUint8(i));
    bytes.setUint8(i + 1, 255 - imageBytes.getUint8(i + 1));
    bytes.setUint8(i + 2, 255 - imageBytes.getUint8(i + 2));
    bytes.setUint8(i + 3, imageBytes.getUint8(i + 3));
  }
  return bytes;
}

/// Reads the red value out of a 32 bit rgba pixel.
int _readRed(int pixel) => (pixel >> 24) & 0xff;

/// Reads the green value out of a 32 bit rgba pixel.
int _readGreen(int pixel) => (pixel >> 16) & 0xff;

/// Reads the blue value out of a 32 bit rgba pixel.
int _readBlue(int pixel) => (pixel >> 8) & 0xff;

/// Reads the alpha value out of a 32 bit rgba pixel.
int _readAlpha(int pixel) => pixel & 0xff;

// Converts a 32 bit abgr pixel to a 32 bit rgba pixel
int _toRGBA(int abgr) =>
    // This is just a mirror of the other conversion.
    _toABGR(abgr);

// Converts a 32 bit rgba pixel to a 32 bit abgr pixel
int _toABGR(int rgba) =>
    (_readAlpha(rgba) << 24) |
    (_readBlue(rgba) << 16) |
    (_readGreen(rgba) << 8) |
    _readRed(rgba);

Future<Image> _createImage(ByteData bytes, int width, int height) {
  final Completer<Image> completer = Completer<Image>();
  decodeImageFromPixels(
    bytes.buffer.asUint8List(),
    width,
    height,
    PixelFormat.rgba8888,
    completer.complete,
  );
  return completer.future;
}
