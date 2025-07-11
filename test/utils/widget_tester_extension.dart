import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:invo_app/app/foundations/theme/theme.dart';
import 'package:invo_app/app/foundations/theme/theme_mode.dart';
import 'package:invo_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'testing_tools.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<String> pumpPage({
    required Widget widget,
    String name = '',
    List<SingleChildWidget> providers = const <SingleChildWidget>[],
  }) async {
    await pumpWidgetBuilder(
      MultiProvider(
        providers: [
          Provider<InvoThemeMode>(create: (context) => InvoThemeMode.standard),
          ...providers,
        ],
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: context.themeData,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          home: widget,
        ),
      ),
    );
    return name;
  }

  Future<String> pumpPageWithStackRouter({
    required Widget widget,
    required String testAdditionalDescription,
    required GoRouter router,
    List<SingleChildWidget> providers = const <SingleChildWidget>[],
  }) async {
    await pumpWidgetBuilder(
      MultiProvider(
        providers: [
          Provider<InvoThemeMode>(create: (context) => InvoThemeMode.standard),
          ...providers,
        ],
        builder: (context, child) => MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: context.themeData,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          builder: (ctx, child) {
            return child ?? widget;
          },
        ),
      ),
    );
    return testAdditionalDescription;
  }
}
