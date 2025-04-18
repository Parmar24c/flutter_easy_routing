import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'route_enums.dart';
import 'route_config.dart';
import 'route_name.dart';

/// Base class for all routes in the application
mixin BaseRoute<T> {
  /// The screen/widget to display for this route
  Widget get screen;

  /// The route name/path identifier
  AppRoutes get routeName;

  /// The transition type for this route
  TransitionType get transitionType => RouteConfig.transitionType;
}

extension GenerateRoute<T> on BaseRoute<T> {
  /// Generate a route with the configured transition
  Route<T> get route {
    return switch (transitionType) {
      TransitionType.fade => _buildFadeRoute(),
      TransitionType.slideUp => _buildSlideUpRoute(),
      TransitionType.slideLeft => _buildSlideLeftRoute(),
      TransitionType.scale => _buildScaleRoute(),
      TransitionType.size => _buildSizeRoute(),
    };
  }

  Route<T> _buildFadeRoute() => (Platform.isIOS)
      ? CupertinoPageRoute(
      settings: RouteSettings(name: routeName.path),
      builder: (BuildContext context) => screen
  )
      : PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    pageBuilder: (context, animation, secondaryAnimation) =>
        FadeTransition(
          opacity: animation,
          child: screen,
        ),
  );

  Route<T> _buildSlideUpRoute() => (Platform.isIOS)
      ? CupertinoPageRoute(
      settings: RouteSettings(name: routeName.path),
      builder: (BuildContext context) => screen
  )
      : PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // slide from the bottom
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );

  Route<T> _buildSlideLeftRoute() => (Platform.isIOS)
      ? CupertinoPageRoute(
      settings: RouteSettings(name: routeName.path),
      builder: (BuildContext context) => screen
  )
      : PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // slide from the right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );

  Route<T> _buildSizeRoute() => (Platform.isIOS)
      ? CupertinoPageRoute(
      settings: RouteSettings(name: routeName.path),
      builder: (BuildContext context) => screen
  )
      : PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Align(
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      );
    },
  );

  Route<T> _buildScaleRoute() => (Platform.isIOS)
      ? CupertinoPageRoute(
      settings: RouteSettings(name: routeName.path),
      builder: (BuildContext context) => screen
  )
      : PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut));

      return ScaleTransition(
        scale: animation.drive(tween),
        child: child,
      );
    },
  );
}


/// Custom route implementation for direct use
class CustomRoute<T> with BaseRoute<T> {
  final Widget page;
  final AppRoutes routename;
  final TransitionType transition;

  CustomRoute({
    required this.routename,
    required this.page,
    required this.transition,
  });

  @override
  Widget get screen => page;

  @override
  AppRoutes get routeName => routename;

  @override
  TransitionType get transitionType => transition;
}