import 'package:flutter/material.dart';

import '../components/header.dart';
import '../components/memory_card.dart';
import '../components/spacing.dart';
import '../controllers/game_controller.dart';
import '../controllers/sounds_controller.dart';
import '../models/card_info.dart';
import '../routes.dart';
import '../values/app_colors.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();
    GameController.instance.ensuredInitializedGame();
    GameController().addListener(checkIfGameIsFinished);
  }

  void checkIfGameIsFinished() async {
    if (!GameController.instance.isGameFinished) return;

    GameController.instance.finishGame();
    Navigator.of(context).pushNamed(Routes.gameSuccess);
  }

  void handleTap(CardInfo card) async {
    await SoundsController.instance.playButtonClickSound();
    GameController().handleCardTap(card);
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(
      vertical: 24.0,
      horizontal: 28.0,
    );

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: padding,
        child: Column(
          children: [
            const Header(),
            const VerticalSpacing(18),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: grid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget grid() {
    return AnimatedBuilder(
      animation: GameController.instance,
      builder: (context, child) => GridView.builder(
        gridDelegate: gridDelegate,
        itemCount: GameController.instance.cards.length,
        itemBuilder: (_, index) {
          final card = GameController().cards[index];

          return Visibility(
            visible: GameController().isCardVisible(card),
            replacement: InkWell(
              onTap: () => handleTap(card),
              child: const MemoryCard(cardInfo: CardInfoAsset()),
            ),
            child: MemoryCard(
              cardInfo: GameController.instance.cards[index],
              isVisible: GameController().selectedCards.contains(card),
            ),
          );
        },
      ),
    );
  }

  SliverGridDelegate get gridDelegate {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 200 / 220,
    );
  }
}
