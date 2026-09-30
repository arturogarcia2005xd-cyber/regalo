import 'package:shared_preferences/shared_preferences.dart';

class ScoreStorageService {
  static const String _keyHighScore = 'chef_pro_high_score';

  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyHighScore) ?? 0;
  }

  static Future<bool> saveHighScore(int score) async {
    final currentHigh = await getHighScore();
    if (score > currentHigh) {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(_keyHighScore, score);
    }
    return false;
  }
}