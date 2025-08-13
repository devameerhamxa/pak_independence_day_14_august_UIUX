import 'package:flutter/material.dart';

class AnimationProvider extends ChangeNotifier {
  bool _isAnimating = false;
  bool _showFireworks = false;
  int _currentQuoteIndex = 0;

  bool get isAnimating => _isAnimating;
  bool get showFireworks => _showFireworks;
  int get currentQuoteIndex => _currentQuoteIndex;

  void startAnimation() {
    _isAnimating = true;
    notifyListeners();
  }

  void stopAnimation() {
    _isAnimating = false;
    notifyListeners();
  }

  void toggleFireworks() {
    _showFireworks = !_showFireworks;
    notifyListeners();
  }

  void nextQuote() {
    _currentQuoteIndex = (_currentQuoteIndex + 1) % 4;
    notifyListeners();
  }

  void resetAnimations() {
    _isAnimating = false;
    _showFireworks = false;
    _currentQuoteIndex = 0;
    notifyListeners();
  }
}
