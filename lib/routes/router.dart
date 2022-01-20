
import 'package:app/models/pokedeks_model.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/search/search_page.dart';
import 'package:flutter/material.dart';

class GenerateRoute {
  static routeGenerator(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/search':
        return MaterialPageRoute(builder: (context) => SearchPage(pokedex: (args as PokedexModel),));
    }
  }
}
