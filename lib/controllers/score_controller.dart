import 'package:shared_preferences/shared_preferences.dart';

class ScoreController {
  ScoreController._();
  factory ScoreController() => _instance;
  static ScoreController get instance => _instance;

  String scoreSavedKey = 'score_key';
  static final ScoreController _instance = ScoreController._();

  Future<void> updateScore(double value, {bool isNegative = false}) async {
    final current = await getScore();
    final newValue = isNegative ? current - value : current + value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(scoreSavedKey, newValue);
  }

  Future<double> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(scoreSavedKey) ?? 0;
  }
}
