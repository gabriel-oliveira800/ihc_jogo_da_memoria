// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';

import '../controllers/game_controller.dart';
import '../controllers/score_controller.dart';
import '../routes.dart';
import '../values/app_colors.dart';

import 'action_icon.dart';
import 'button.dart';
import 'spacing.dart';

class Header extends StatefulWidget {
  final String infoText;
  final bool showRestarButton;

  const Header({
    Key? key,
    this.showRestarButton = true,
    this.infoText = 'Jogar novamente?',
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Timer? _timer;
  double _progressValue = 1.0;
  double _progressDifficult = 0.005;
  final _processStream = StreamController<double>.broadcast();

  @override
  void initState() {
    super.initState();
    GameController.instance.addListener(() {
      if (GameController.instance.gameStarted) {
        _handleInitalzedTimer();

        const diff = {
          GameDifficulty.easy: 0.008,
          GameDifficulty.medium: 0.02,
          GameDifficulty.hard: 0.1,
        };

        setState(() {
          _progressDifficult = diff[GameController.instance.difficulty] ?? 0.005;
        });
      }

      if (GameController.instance.isGameFinished) {
        _timer?.cancel();
        _timer = null;
        _progressValue = 1.0;
        if (!_processStream.isClosed) {
          _processStream.close();
        }
      }
    });

    _processStream.stream.listen((process) => handleGameOver(process <= 0.0));
  }

  void handleGameOver(bool isFinished) async {
    if (!isFinished) return;

    _timer?.cancel();
    _timer = null;
    _progressValue = 1.0;
    GameController.instance.finishGame();
    await ScoreController.instance.updateScore(100, isNegative: true);

    Navigator.of(context).pushNamed(Routes.gameOver);
  }

  void _handleInitalzedTimer() {
    _timer?.cancel();
    _timer = null;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _progressValue -= _progressDifficult;
      _processStream.add(_progressValue);
    });
  }

  void handleBack(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          ActionIcon(
            svgSource: 'assets/images/home.svg',
            onPressed: () => handleBack(context),
          ),
          const HorizontalSpacing(16),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.showRestarButton,
                  replacement: AnimatedBuilder(
                    animation: GameController.instance,
                    builder: (context, child) => Center(
                      child: Visibility(
                        visible: !GameController.instance.gameStarted,
                        replacement: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _process(),
                        ),
                        child: const Text(
                          'Memorize as cartas',
                          style: TextStyle(
                            fontSize: 26,
                            letterSpacing: 0.3,
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.infoText,
                      style: const TextStyle(
                        fontSize: 26,
                        letterSpacing: 0.3,
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (widget.showRestarButton) const HorizontalSpacing(16),
          if (widget.showRestarButton)
            Button(
              text: 'Reiniciar',
              onPressed: () async {
                _processStream.add(_progressValue);
                _timer?.cancel();
                _timer = null;

                await GameController.instance.ensuredInitializedGame();
                _progressValue = 1.0;
                _handleInitalzedTimer();
              },
              style: Button.defaultStyle.copyWith(
                fontSize: 20,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
    );
  }

  Widget _process() {
    return StreamBuilder<double>(
      initialData: _progressValue,
      stream: _processStream.stream,
      builder: (context, snapshot) => LinearProgressIndicator(
        minHeight: 48,
        value: snapshot.data,
        color: AppColors.gray,
        backgroundColor: AppColors.gray,
        valueColor: const AlwaysStoppedAnimation(AppColors.tertiary),
      ),
    );
  }
}
