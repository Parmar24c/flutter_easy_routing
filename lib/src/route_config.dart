import 'route_enums.dart';

class RouteConfig {
  /// Default transition type used for routes
  static TransitionType transitionType = TransitionType.slideLeft;

  /// Configure global transition type
  static void setDefaultTransition(TransitionType type) {
    transitionType = type;
  }
}