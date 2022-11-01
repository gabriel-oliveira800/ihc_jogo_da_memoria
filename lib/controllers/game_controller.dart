import 'dart:math';

import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../models/card_info.dart';

import 'score_controller.dart';

enum GameDifficulty {
  easy,
  medium,
  hard,
}

class GameController extends ChangeNotifier {
  GameController._();
  factory GameController() => _instance;
  static GameController get instance => _instance;

  static final GameController _instance = GameController._();

  bool gameOver = false;
  bool gameStarted = false;
  bool isGameFinished = false;
  bool viewCardToMemorized = false;

  List<CardInfo> cards = [];
  int seedGeneratedImgs = 0;
  GameDifficulty difficulty = GameDifficulty.easy;

  int get maxGeneratedCards => 10;

  Future<void> ensuredInitializedGame() async {
    cards = [];
    gameStarted = false;
    notifyListeners();

    await toggleCardVisibility();

    final imgs = List.generate(
      maxGeneratedCards ~/ 2,
      (index) => MapEntry<String, String>(
        const Uuid().v4(),
        'https://source.unsplash.com/random?sig=${index + seedGeneratedImgs}/200x200',
      ),
    );

    for (int i = 0; i < maxGeneratedCards; i++) {
      final data = imgs[i % (maxGeneratedCards ~/ 2)];
      cards.add(CardInfoNetwork(
        id: data.key,
        url: data.value,
        decoration: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data.value),
        ),
      ));
    }

    cards.shuffle();
    await toggleCardVisibility(duration: const Duration(seconds: 8));

    gameStarted = true;
    seedGeneratedImgs = Random().nextInt(255);
    notifyListeners();
  }

  Future<void> toggleCardVisibility({Duration? duration}) async {
    await Future.delayed(duration ?? const Duration(milliseconds: 500));
    viewCardToMemorized = !viewCardToMemorized;
    notifyListeners();
  }

  List<CardInfo> selectedCards = [];

  void handleCardTap(CardInfo card) async {
    selectedCards.add(card);
    notifyListeners();

    if (selectedCards.length >= 2) _handleUpdateCard();
  }

  void _handleUpdateCard() async {
    final isCardSame = selectedCards.first.isSameCard(selectedCards.last);

    if (!isCardSame) {
      await Future.delayed(const Duration(milliseconds: 500));

      selectedCards.clear();
      notifyListeners();

      return;
    }

    final firstCardIndex = cards.indexOf(selectedCards.first);
    final lastCardIndex = cards.indexOf(selectedCards.last);

    cards[lastCardIndex] = cards[lastCardIndex].copyWith(isActive: true);
    cards[firstCardIndex] = cards[firstCardIndex].copyWith(isActive: true);

    selectedCards.clear();
    isGameFinished = cards.every((card) => card.isActive);
    if (isGameFinished) {
      await ScoreController.instance.updateScore(100);
    }

    notifyListeners();
  }

  bool isCardVisible(CardInfo card) {
    return viewCardToMemorized || card.isActive || selectedCards.contains(card);
  }

  void chooseDifficulty(GameDifficulty value) {
    difficulty = value;
    notifyListeners();
  }

  void finishGame() async {
    gameStarted = false;
    isGameFinished = false;
    viewCardToMemorized = false;

    notifyListeners();
  }
}
