import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:injectable/injectable.dart';
import 'package:invo_app/app/foundations/theme/theme.dart';
import 'package:invo_app/app/foundations/theme/theme_mode.dart';
import 'package:invo_app/app/routing/go_router.dart' show InvoRouter;
import 'package:invo_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart' as pr;

const integrationTest = Environment('integrationTest');

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final invoRouter = InvoRouter();
    return pr.MultiProvider(
      providers: [
        pr.Provider<InvoThemeMode>(create: (_) => InvoThemeMode.standard),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Insylio',
            theme: context.themeData,
            locale: Locale.fromSubtags(languageCode: 'pl'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: invoRouter.goRouter.routerDelegate,
            routeInformationParser: invoRouter.goRouter.routeInformationParser,
            routeInformationProvider:
                invoRouter.goRouter.routeInformationProvider,
            builder: (ctx, child) {
              return child ?? SizedBox();
            },
          );
        },
      ),
    );
  }
}
