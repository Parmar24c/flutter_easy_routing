import 'package:example/pages/next_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_routing/flutter_easy_routing.dart';

import '../main.dart';

class DefaultRoutePage extends StatelessWidget with BaseRoute {
  const DefaultRoutePage({super.key});

  @override
  AppRoutes get routeName => Routes.defaultRoute;

  @override
  Widget get screen => this;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Default Route")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(NextPage(count: 1, transitionType: transitionType));
              },
              child: Text("Next Page"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
