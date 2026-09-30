import 'package:flutter/services.dart';

class HapticService {
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  static void errorVibration() {
    HapticFeedback.vibrate();
  }
}