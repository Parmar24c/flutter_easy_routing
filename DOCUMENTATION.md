# Flutter Easy Routing - API Documentation

## Core Classes

### AppRouter

Static utility class for generating routes and managing navigation.

#### Methods

- `static Route generateRoute(RouteSettings settings, BaseRoute defaultRoute, {Widget Function(BuildContext, String?)? routeNotFoundBuilder})` - Generate a route based on route settings.
- `static Route generateRouteWithMapping(RouteSettings settings, Map<String, BaseRoute> routes, {BaseRoute? defaultRoute, Widget Function(BuildContext, String?)? routeNotFoundBuilder})` - Generate a route using a mapping of route names to route implementations.

#### Properties

- `static GlobalKey<NavigatorState> navigatorKey` - Global navigator key for accessing navigator state.
- `static BuildContext get context` - Global navigation context.
- `static NavigatorState get state` - Global navigator state.

### BaseRoute

Mixin that defines the basic structure for all routes.

#### Properties to Implement

- `Widget get screen` - The widget/screen to display.
- `AppRoutes get routeName` - The route identifier.
- `TransitionType get transitionType` - (Optional) The transition animation type.

#### Extension Methods

- `Route<T> get route` - Generate a route with the configured transition.

### AppRoutes

Abstract class for defining route names in a type-safe way.

#### Properties

- `final String name` - The route name.
- `String get path` - The route path (prefixed with /).

### RouteConfig

Static utility class for configuring global route settings.

#### Methods

- `static void setDefaultTransition(TransitionType type)` - Set the default transition type for all routes.

#### Properties

- `static TransitionType transitionType` - The default transition type.

### CustomRoute

Implementation of BaseRoute for quick route creation.

#### Constructor

- `CustomRoute({required AppRoutes routename, required Widget page, required TransitionType transition})` - Create a route with specific properties.

## Enums

### TransitionType

Available transition animation types:

- `fade` - Fade in/out transition
- `slideUp` - Slide from bottom
- `slideLeft` - Slide from right
- `scale` - Scale transition
- `size` - Size transition

## Extension Methods

Flutter Easy Routing provides context-based extension methods for navigation:

- `pushNamed(BaseRoute route)` - Navigate to a route
- `push(Route<T> route)` - Push a route directly
- `pushReplacement(BaseRoute<T> route, {TO? result})` - Replace current route
- `pushAndRemoveUntil(BaseRoute<T> newRoute, RoutePredicate predicate)` - Push route and remove routes until predicate is met
- `popUntil(RoutePredicate predicate)` - Pop routes until predicate is met
- `pop([T? result])` - Go back to previous route
- `maybePop([T? result])` - Pop if possible
- ... and many more equivalent to Flutter's Navigator methods

## RouteTransitions

Static utility class for custom transition animations:

- `static Widget fadeTransition(...)` - Fade transition
- `static Widget slideUpTransition(...)` - Slide up transition
- `static Widget slideLeftTransition(...)` - Slide left transition
- `static Widget scaleTransition(...)` - Scale transition
- `static Widget sizeTransition(...)` - Size transition