import 'package:example/pages/next_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_routing/flutter_easy_routing.dart';

import '../main.dart';

class SlideLeftRoutePage extends StatelessWidget with BaseRoute {
  const SlideLeftRoutePage({super.key});

  @override
  AppRoutes get routeName => Routes.slideLeftRoute;

  @override
  Widget get screen => this;

  @override
  TransitionType get transitionType => TransitionType.slideLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slide Left Route")),
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
