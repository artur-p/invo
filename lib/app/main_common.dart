import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invo_app/app/app.dart';
import 'package:invo_app/app/configs/base_configs.dart';
import 'package:logging/logging.dart';

import 'di/injector.dart';
import 'error_handling/crashlytics_error_listener.dart';
import 'error_handling/error_handler.dart';
import 'logging/configure_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

final _logger = Logger('main');

final _errorHandler = InvoErrorHandler.instance
  ..addListener(CrashlyticsErrorListener());

Future<void> mainCommon({required Environment environment}) async {
  await runZonedGuarded(
    () async {
      configureLogger();
      _logger.fine('Starting app');
      WidgetsFlutterBinding.ensureInitialized();
      configureDependencies(environment: environment);

      final baseConfigs = GetIt.I.get<BaseConfigs>();

      _logger.fine('App identifier: ${baseConfigs.identifier}');

      FlutterError.onError = _errorHandler.onFlutterError;
      PlatformDispatcher.instance.onError = _errorHandler.onPlatformError;

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      Bloc.observer = AppBlocObserver();

      _logger.fine('Running app');
      runApp(App());
    },
    _errorHandler.onError,
    zoneValues: {'ZoneName': 'RootZone'},
  );
}
