import 'package:flutter/material.dart';

import 'package:ihc_jogo_da_memoria/routes.dart';

import '../components/button.dart';
import '../components/header.dart';
import '../components/spacing.dart';
import '../values/app_colors.dart';

class GameSuccess extends StatefulWidget {
  const GameSuccess({Key? key}) : super(key: key);

  @override
  State<GameSuccess> createState() => _GameSuccessState();
}

class _GameSuccessState extends State<GameSuccess> {
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
            const Header(
              showRestarButton: false,
              infoText: 'Parabéns!',
            ),
            const VerticalSpacing(18),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Center(child: gameOverText()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameOverText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Parabéns! você ganhou!',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2,
            fontSize: 84,
            fontFamily: 'Fredoka',
            color: AppColors.tertiary,
          ),
        ),
        const VerticalSpacing(48),
        const Text(
          'Aproveite e jogue novamente aumentando o nível de dificuldade nas configurações.',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2,
            fontSize: 24,
            color: AppColors.tertiary,
          ),
        ),
        const VerticalSpacing(48),
        Button(
          text: 'Jogar Novamente',
          onPressed: () => Navigator.of(context).popAndPushNamed(Routes.game),
          style: Button.defaultStyle.copyWith(
            fontSize: 20,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
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