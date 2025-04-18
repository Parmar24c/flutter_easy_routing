import 'package:example/pages/default_route_page.dart';
import 'package:example/pages/scale_route_page.dart';
import 'package:example/pages/size_route_page.dart';
import 'package:example/pages/slide_left_route_page.dart';
import 'package:example/pages/slide_up_route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_routing/flutter_easy_routing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /// TODO : set default transition for whole app
  RouteConfig.setDefaultTransition(TransitionType.fade);
  runApp(const MyApp());
}

/// Define your route names by extending [AppRoutes]
class Routes extends AppRoutes {
  const Routes._(super.name);

  static const home = Routes._("home");
  static const defaultRoute = Routes._("defaultRoute");
  static const next = Routes._("next");
  static const scaleRoute = Routes._("scaleRoute");
  static const sizeRoute = Routes._("sizeRoute");
  static const slideUpRoute = Routes._("slideUpRoute");
  static const slideLeftRoute = Routes._("slideLeftRoute");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

/// TODO : add [BaseRoute] mixin with Screen/Page
class MyHomePage extends StatefulWidget with BaseRoute {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  /// TODO : override following properties
  @override
  AppRoutes get routeName => Routes.home;

  @override
  Widget get screen => this;

  /// ([transitionType] is optional, if not given than takes default that set by[RouteConfig.setDefaultTransition])
  @override
  TransitionType get transitionType => TransitionType.fade;
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter Easy Routing Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(DefaultRoutePage());
              },
              child: Text("Default Route Page"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(SlideLeftRoutePage());
              },
              child: Text("Slide Left Route Page"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(SlideUpRoutePage());
              },
              child: Text("Slide Up Route Page"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(ScaleRoutePage());
              },
              child: Text("Scale Route Page"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(SizeRoutePage());
              },
              child: Text("Size Route Page"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
