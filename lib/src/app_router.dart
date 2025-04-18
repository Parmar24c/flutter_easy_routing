import 'package:flutter/material.dart';
import 'route_base.dart';

/// Global navigator key for accessing navigator state

/// Main router class for generating routes
class AppRouter {
  /// Private constructor to prevent instantiation
  AppRouter._();

  /// Global navigator key for routing
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Global navigation context
  static BuildContext get context {
    try {
      return navigatorKey.currentContext!;
    } catch(e){
      throw Exception("Context not available. Please check that you use 'AppRouter.navigatorKey' in you main.dart's MaterialApp");
    }
  }

  static NavigatorState get state {
    try {
      return navigatorKey.currentState!;
    } catch(e){
      throw Exception("NavigatorState not available. Please check that you use 'AppRouter.navigatorKey' in you main.dart's MaterialApp");
    }
  }

  /// Generate a route based on route settings
  ///
  /// [settings] - Route settings with name and arguments
  /// [defaultRoute] - Default route to use if arguments not provided
  /// [routeNotFoundBuilder] - Optional builder for when a route is not found
  static Route generateRoute(
      RouteSettings settings,
      BaseRoute defaultRoute, {
        Widget Function(BuildContext, String?)? routeNotFoundBuilder,
      }) {
    // Check if arguments contain a BaseRoute implementation
    if (settings.arguments is BaseRoute) {
      return (settings.arguments as BaseRoute).route;
    }

    // Use default route if provided
    return defaultRoute.route;
  }

  /// Generate a route based on route settings with route mapping
  ///
  /// [settings] - Route settings with name and arguments
  /// [routes] - Map of route names to BaseRoute implementations
  /// [defaultRoute] - Optional default route if no match is found
  static Route generateRouteWithMapping(
      RouteSettings settings,
      Map<String, BaseRoute> routes, {
        BaseRoute? defaultRoute,
        Widget Function(BuildContext, String?)? routeNotFoundBuilder,
      }) {
    // Check if route exists in the provided map
    if (routes.containsKey(settings.name)) {
      // If arguments contain a BaseRoute, use that instead of the mapped route
      if (settings.arguments is BaseRoute) {
        return (settings.arguments as BaseRoute).route;
      }

      // Use the mapped route
      return routes[settings.name]!.route;
    }

    // Handle route not found
    if (defaultRoute != null) {
      return defaultRoute.route;
    }

    // Return error route if no default provided
    return MaterialPageRoute(
      builder: (context) => routeNotFoundBuilder != null
          ? routeNotFoundBuilder(context, settings.name)
          : _DefaultErrorScreen(name: settings.name),
    );
  }

  // /// Navigate to a route using the root navigator
  // static Future<T?> navigateTo<T>(BaseRoute<T> route) {
  //   return navigatorKey.currentState!.push(route.route);
  // }
  //
  // /// Navigate to a route and remove all previous routes
  // static Future<T?> navigateAndRemoveUntil<T>(BaseRoute<T> route) {
  //   return navigatorKey.currentState!.pushAndRemoveUntil(
  //     route.route,
  //         (route) => false,
  //   );
  // }
  //
  // /// Navigate to a named route
  // static Future<T?> navigateToNamed<T>(String routeName, {Object? arguments}) {
  //   return navigatorKey.currentState!.pushNamed<T>(
  //     routeName,
  //     arguments: arguments,
  //   );
  // }
  //
  // /// Navigate back
  // static void goBack<T>([T? result]) {
  //   if (navigatorKey.currentState!.canPop()) {
  //     navigatorKey.currentState!.pop(result);
  //   }
  // }
}

/// Default error screen shown when a route is not found
class _DefaultErrorScreen extends StatelessWidget {
  final String? name;

  const _DefaultErrorScreen({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Route Not Found")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              "No route found for: ${name ?? 'unknown'}",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}