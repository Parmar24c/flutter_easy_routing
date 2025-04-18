import 'package:flutter/material.dart';
import 'package:flutter_easy_routing/flutter_easy_routing.dart';

import '../main.dart';

class NextPage extends StatelessWidget with BaseRoute {
  final int count;
  final TransitionType transitionType;

  const NextPage({super.key, required this.count, required this.transitionType});

  @override
  AppRoutes get routeName => Routes.next;

  @override
  Widget get screen => this;

  Color getRandomLightColor() {
    final List<Color> lightColors = [
      Colors.pink.shade100,
      Colors.blue.shade100,
      Colors.yellow.shade100,
      Colors.green.shade100,
      Colors.purple.shade100,
      Colors.orange.shade100,
      Colors.cyan.shade100,
      Colors.teal.shade100,
      Colors.amber.shade100,
      Colors.lime.shade100,
    ];

    return lightColors[count % lightColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getRandomLightColor(),
      appBar: AppBar(title: Text("Next Route $count of ${transitionType.name} type")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(NextPage(count: count + 1, transitionType: transitionType));
              },
              child: Text("Next Page"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: Text("Go Back"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushAndRemoveUntil(MyHomePage(), (route) => route.settings.name == Routes.home.path);
              },
              child: Text("Go Back To Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}
