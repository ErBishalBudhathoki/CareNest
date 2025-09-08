import 'package:flutter/material.dart';
import 'base_screen.dart';

abstract class BasePage {
  final String name;
  final BaseScreen screen;

  BasePage({
    required this.name,
    required this.screen,
  });

  Route<dynamic> getRoute() {
    return MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(name: name),
    );
  }
}
