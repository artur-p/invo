import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/constants/fonts.gen.dart';

class AppTextStyle extends TextStyle {
  const AppTextStyle._({
    required double super.fontSize,
    super.color,
    super.fontWeight,
    super.height,
    super.wordSpacing,
    bool underline = false,
  }) : super(
         decoration: underline ? TextDecoration.underline : null,
         fontFamily: FontFamily.interDisplay,
       );

  @override
  double get fontSize => super.fontSize!;
}

extension AppTextStylesBuildContextExtension on BuildContext {
  AppTextStyles get textStyles => AppTextStyles._(colors);
}

class AppTextStyles {
  const AppTextStyles._(this.colors);

  final InvoColors colors;

  AppTextStyle get _displayMedium => AppTextStyle._(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: colors.textColor1,
  );

  AppTextStyle get _displaySmall => AppTextStyle._(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: colors.textColor1,
  );

  AppTextStyle get _headlineSmall => AppTextStyle._(
    fontSize: 24,
    color: colors.textColor1,
    height: 1.4,
    fontWeight: FontWeight.w600,
  ); //0.4% letter spacing

  AppTextStyle get _titleLarge => AppTextStyle._(
    fontSize: 18,
    color: colors.textColor1,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  AppTextStyle get _headlineMedium => AppTextStyle._(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: colors.textColor1,
  );

  AppTextStyle get _titleMedium => const AppTextStyle._(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  AppTextStyle get _labelSmall => AppTextStyle._(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: colors.textColor1,
  );

  AppTextStyle get _labelMedium => AppTextStyle._(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: colors.textColor1,
  );

  AppTextStyle get _labelLarge => AppTextStyle._(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: colors.textColor2,
  );

  AppTextStyle get _bodySmall => AppTextStyle._(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1,
    color: colors.textColor2,
  );

  AppTextStyle get _bodyMedium => AppTextStyle._(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: colors.textColor2,
  );

  AppTextStyle get _titleSmall => AppTextStyle._(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: colors.textColor2,
    wordSpacing: 0,
  );

  AppTextStyle get _bodyLarge => AppTextStyle._(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1,
    color: colors.textColor1,
  );

  AppTextStyle get _headlineLarge => AppTextStyle._(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: colors.textColor1,
  );

  AppTextStyle get inputHint => AppTextStyle._(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: colors.textColor1,
  );

  TextTheme get textTheme => TextTheme(
    displayMedium: _displayMedium,
    displaySmall: _displaySmall,
    headlineSmall: _headlineSmall,
    headlineMedium: _headlineMedium,
    headlineLarge: _headlineLarge,
    titleLarge: _titleLarge,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
    labelSmall: _labelSmall,
    labelMedium: _labelMedium,
    labelLarge: _labelLarge,
    bodySmall: _bodySmall,
    bodyMedium: _bodyMedium,
    bodyLarge: _bodyLarge,
  );
}
