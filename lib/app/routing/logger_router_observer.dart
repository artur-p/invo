import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class LoggerRouterObserver extends NavigatorObserver {
  LoggerRouterObserver();

  static final _logger = Logger('LoggerRouterObserver');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.info('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.info('Route popped: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.info('Route removed: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger.info(
      'Route replaced: ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );
  }
}
