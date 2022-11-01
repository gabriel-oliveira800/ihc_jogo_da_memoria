import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../components/action_icon.dart';
import '../components/button.dart';
import '../components/settings.dart';
import '../components/spacing.dart';
import '../controllers/score_controller.dart';
import '../controllers/sounds_controller.dart';
import '../values/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onPlayGame() {
    Navigator.of(context).pushNamed('/game');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          Positioned(
            left: -140,
            bottom: -100,
            child: SvgPicture.asset(
              'assets/images/illustration.svg',
              color: AppColors.tertiaryLight,
              height: 600,
            ),
          ),
          Positioned(
            top: -300,
            right: -200,
            child: SvgPicture.asset(
              'assets/images/illustration.svg',
              color: AppColors.tertiaryLight,
              height: 600,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: FutureBuilder<double>(
                initialData: 0,
                future: ScoreController.instance.getScore(),
                builder: (_, snapshot) => Text(
                  'Pontuação: ${snapshot.data}',
                  style: const TextStyle(
                    fontSize: 38,
                    fontFamily: 'Fredoka',
                    color: AppColors.text,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Expanded(flex: 2, child: _title()),
                  const SizedBox(height: 60),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Button(
                          text: 'Jogar',
                          onPressed: _onPlayGame,
                        ),
                        const VerticalSpacing(24),
                        _actions(),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Jogo da \nMemória',
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.2,
        fontSize: 85,
        fontFamily: 'Fredoka',
        color: AppColors.tertiary,
      ),
    );
  }

  Widget _actions() {
    return SizedBox(
      width: 234,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedBuilder(
            animation: SoundsController.instance,
            builder: (context, widget) => ActionIcon(
              activeIcon: Icons.music_note_rounded,
              desableIcon: Icons.music_off_rounded,
              isActive: SoundsController.instance.isMusicOn,
              onPressed: SoundsController.instance.toggleBackgroundMusic,
            ),
          ),
          const HorizontalSpacing(16),
          ActionIcon(
            onPressed: showSettings,
            activeIcon: Icons.settings_rounded,
          ),
          const HorizontalSpacing(16),
          AnimatedBuilder(
            animation: SoundsController.instance,
            builder: (context, child) => ActionIcon(
              activeIcon: Icons.volume_up_rounded,
              desableIcon: Icons.volume_off_rounded,
              isActive: SoundsController.instance.isEffectsOn,
              onPressed: SoundsController.instance.toggleEffects,
            ),
          ),
        ],
      ),
    );
  }

  void showSettings() {
    showDialog(
      context: context,
      barrierColor: AppColors.tertiaryLight.withOpacity(0.2),
      builder: (context) => const Settings(),
    );
  }
}
