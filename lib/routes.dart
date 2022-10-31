import 'package:flutter/widgets.dart';

import 'package:ihc_jogo_da_memoria/pages/game_success.dart';
import 'package:ihc_jogo_da_memoria/pages/home.dart';

import 'pages/game.dart';
import 'pages/game_over.dart';

abstract class Routes {
  static const String home = '/';
  static const String game = '/game';
  static const String gameOver = '/game-over';
  static const String gameSuccess = '/game-success';

  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.home: (context) => const Home(),
      Routes.game: (context) => const Game(),
      Routes.gameOver: (context) => const GameOver(),
      Routes.gameSuccess: (context) => const GameSuccess(),
    };
  }
}
