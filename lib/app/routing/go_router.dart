import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:invo_app/features/meal_details/presentation/view/meal_details_page.dart';

import 'logger_router_observer.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

enum RoutePath {
  mealDetailsPage(path: '/');

  const RoutePath({required this.path});
  final String path;
}

class InvoRouter {
  InvoRouter()
    : goRouter = GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: rootNavigatorKey,
        initialLocation: RoutePath.mealDetailsPage.path,
        observers: [LoggerRouterObserver()],
        routes: [
          GoRoute(
            path: RoutePath.mealDetailsPage.path,
            name: RoutePath.mealDetailsPage.name,
            builder: (context, state) => const MealDetailsPage(mealId: 1),
          ),
        ],
      );

  late GoRouter goRouter;
}
