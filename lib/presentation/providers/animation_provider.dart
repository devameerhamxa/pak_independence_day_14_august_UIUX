import 'package:flutter/material.dart';
import 'package:pak_independence_day_14_august/core/constants/app_constants.dart';

class AnimationProvider extends ChangeNotifier {
  bool _isAnimating = true; // Start animating by default
  bool _showFireworks = false;
  int _currentQuoteIndex = 0;
  bool _introFinished = false; // New state for intro animation

  bool get isAnimating => _isAnimating;
  bool get showFireworks => _showFireworks;
  int get currentQuoteIndex => _currentQuoteIndex;
  bool get introFinished => _introFinished;

  void finishIntro() {
    _introFinished = true;
    notifyListeners();
  }

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
    _currentQuoteIndex = (_currentQuoteIndex + 1) % AppConstants.quotes.length;
    notifyListeners();
  }

  void resetAnimations() {
    _isAnimating = true;
    _showFireworks = false;
    _currentQuoteIndex = 0;
    _introFinished = false; // Reset intro state
    notifyListeners();
  }
}
