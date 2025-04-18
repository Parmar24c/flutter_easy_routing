# Flutter Easy Routing

A lightweight, flexible routing solution for Flutter applications that simplifies route management with type-safe navigation and customizable transitions.

[![pub package](https://img.shields.io/pub/v/flutter_easy_routing.svg)](https://pub.dev/packages/flutter_easy_routing)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

![Flutter Easy Routing](flutter_easy_routing_image.png)

## Features

- 🧭 **Type-safe navigation** - No more string-based routes
- 🔄 **Custom transitions** - Smooth animations between screens
- 🛣️ **Route generation** - Simplified route setup
- 🗺️ **Route mapping** - Easy management of route names
- 📱 **Platform adaptive** - Uses CupertinoPageRoute on iOS
- 🧩 **Extension methods** - Intuitive context-based navigation APIs

## Installation

Add flutter_easy_routing to your pubspec.yaml:

```yaml
dependencies:
  flutter_easy_routing: ^0.0.2
```

Then run:

```bash
flutter pub get
```

Import the package:

```dart
import 'package:flutter_easy_routing/flutter_easy_routing.dart';
```

## Basic Usage

### Setup

1. Define your route names by extending `AppRoutes`:

```dart
class Routes extends AppRoutes {
  const Routes._(super.name);

  static const home = Routes._('home');
  static const profile = Routes._('profile');
  static const settings = Routes._('settings');
}
```

2. Configure the navigator in your MaterialApp:

```dart
MaterialApp(
    title: 'Flutter Easy Routing Demo',
    debugShowCheckedModeBanner: false,

    /// TODO : add following configuations
    navigatorKey: AppRouter.navigatorKey,
    onGenerateRoute: (settings) => AppRouter.generateRoute(settings, MyHomePage()),
    //

    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
    ),
)
```

### Create Routes

Create routes by implementing the `BaseRoute` mixin:

```dart
class MyHomePage extends StatefulWidget with BaseRoute {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  /// TODO : override following properties (transitionType is option, if not given than takes default that set on material app)
  @override
  AppRoutes get routeName => Routes.home;

  @override
  Widget get screen => this;

  @override
  TransitionType get transitionType => TransitionType.fade;
}
/// next code
```

### Navigation

Navigate using context extensions:

```dart
// Navigate to a route
context.push(HomePage().route);

// Navigate to a named route
context.pushNamed(HomePage());

// Replace current route
context.pushReplacement(ProfilePage());

// Clear stack and navigate
context.pushAndRemoveUntil(HomePage(), (route) => route.settings.name == Routes.home.path);

// Go back
context.pop();

/// and all other methods like Navigator..
```

### Global Context

If you have no context than AppRouter provide navigation context:

```dart
final BuildContext context = AppRouter.context;
```

### Global Navigator State

```dart
final NavigatorState navigatorState = AppRouter.state;
```

### Transition Types

You can choose from several transition types:

- `TransitionType.fade` - Fade transition
- `TransitionType.slideUp` - Slide up from bottom
- `TransitionType.slideLeft` - Slide in from right
- `TransitionType.scale` - Scale transition
- `TransitionType.size` - Size transition

Set a global default transition:

```dart
void main() {
  RouteConfig.setDefaultTransition(TransitionType.slideLeft);
  runApp(MyApp());
}
```

### Route with Arguments

Pass arguments with your routes:

```dart

class NextPage extends StatelessWidget with BaseRoute {
  final int count;

  const NextPage({super.key, required this.count});

  @override
  AppRoutes get routeName => Routes.next;

  @override
  Widget get screen => this;

  /// --- other code --
}

// Navigate with arguments
context.pushNamed(NextPage(count: 10));
```

### Custom Route

Use the `CustomRoute` class for quick route creation without defining a separate class:

```dart
final detailsRoute = CustomRoute(
  routename: Routes.details,
  page: DetailsScreen(item: selectedItem),
  transition: TransitionType.scale,
);

context.pushNamed(detailsRoute);
```

<p align="center">
  🌟 Love this package? Give it a ⭐ on GitHub & show some 💖 — your support means everything!
  <br>
  ~ 👤 Nayan Parmar
</p>

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
