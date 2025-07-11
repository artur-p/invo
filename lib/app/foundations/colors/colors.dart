import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/theme/theme_mode.dart';
import 'package:provider/provider.dart';

part 'standard_mode_colors.dart';

class InvoColor extends Color {
  const InvoColor._(super.value);
}

extension AppColorsBuildContextExtension on BuildContext {
  InvoColors get colors => read<InvoThemeMode>().colors(this);
  InvoColors get watchColors => watch<InvoThemeMode>().colors(this);
}

extension AppThemeModeExt on InvoThemeMode {
  InvoColors colors(BuildContext context) {
    // TODO(Artur): For now return standard colors. Contrast and dark colors are not implemented yet
    return const _StandardModeColors();
    // switch (this) {
    //   // case AppThemeMode.dark:
    //   //   return const _DarkModeColors();
    //   case AppThemeMode.contrast:
    //     return const _StandardModeColors();
    // }
  }
}

abstract class InvoColors {
  const InvoColors();

  InvoColor get transparent => _BasicColors.transparent;
  InvoColor get main;
  InvoColor get splash;
  InvoColor get appBarBackground;
  InvoColor get macronutrientBg;
  InvoColor get dark;

  InvoColor get appBarTitle;
  InvoColor get tilesBg1;
  InvoColor get textColor1;
  InvoColor get textColor2;
  InvoColor get textColor3;
  InvoColor get disabled;
  Color get background;
  InvoColor get selectedItemColor;
  InvoColor get unselectedItemColor;
  InvoColor get error;
  InvoColor get gradient1;
  InvoColor get gradient2;
  InvoColor get gradient3;
  InvoColor get gradient4;
  InvoColor get gradient5;
  InvoColor get hint;
  InvoColor get choiceChipGradient1;
  InvoColor get choiceChipGradient2;
  InvoColor get choiceChipGradient3;
  InvoColor get choiceChipGradient4;
  InvoColor get choiceChipGradient5;
  InvoColor get choiceChipBorder;
  InvoColor get topBarGradient;
  InvoColor get blurShadow;
  Color get overlay;
}

class _BasicColors {
  static const InvoColor transparent = InvoColor._(0x00000000);
}
