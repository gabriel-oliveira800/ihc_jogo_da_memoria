import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

class SoundsController extends ChangeNotifier {
  final AudioPlayer effectsAudioPlayer = AudioPlayer()
    ..setAsset('assets/sounds/button-click.wav');

  final AudioPlayer musicAudioPlayer = AudioPlayer()
    ..setAsset('assets/sounds/background-music.mp3')
    ..setLoopMode(LoopMode.all)
    ..setVolume(0.75)
    ..play();

  bool isMusicOn = true;
  bool isEffectsOn = true;

  SoundsController._();
  factory SoundsController() => _instance;
  static SoundsController get instance => _instance;

  static final SoundsController _instance = SoundsController._();

  void toggleEffects() {
    isEffectsOn = !isEffectsOn;
    notifyListeners();
  }

  void toggleBackgroundMusic() {
    isMusicOn ? musicAudioPlayer.pause() : musicAudioPlayer.play();

    isMusicOn = !isMusicOn;
    notifyListeners();
  }

  Future<void> playButtonClickSound({VoidCallback? onPressed}) async {
    if (isEffectsOn) {
      await effectsAudioPlayer.load();
      await effectsAudioPlayer.play();
    }

    onPressed?.call();
  }
}
