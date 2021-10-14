import 'package:clypto/presentation/details/view/details.dart';
import 'package:clypto/presentation/home/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute(builder: (context) => (HomePage()));
      case Routes.DETAILS:
        return MaterialPageRoute(builder: (context) => (DetailsPage()));

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

abstract class Routes {
  static const HOME = 'homeScreen';
  static const DETAILS = 'detailScreen';
}
