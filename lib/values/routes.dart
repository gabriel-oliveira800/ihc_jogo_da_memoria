import 'package:flutter/material.dart';

import '../pages/game.dart';
import '../pages/home.dart';

typedef AppRoutes = Map<String, WidgetBuilder>;

abstract class Routes {
  static const String home = '/home';
  static const String game = '/game';

  static final AppRoutes handle = <String, WidgetBuilder>{
    home: (context) => const Home(),
    game: (context) => const Game(),
  };
}
