import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';
import 'package:invo_app/constants/fonts.gen.dart';

extension AppThemeDataBuildContextExtension on BuildContext {
  ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: colors.background,
      fontFamily: FontFamily.interDisplay,
      textTheme: textStyles.textTheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
