import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

import 'values/app_colors.dart';
import 'values/routes.dart';

void main() => runApp(const MemoryGame());

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _setupAudioLoaded();
  }

  void _setupAudioLoaded() async {
    await _player.setAsset('assets/sounds/free-music-background.mp3');
    await _player.play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      routes: Routes.handle,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
