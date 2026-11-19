import 'dart:async';

import 'package:flutter/material.dart';

import '../models/splash_model.dart';
import '../repositories/splash_repository.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepository _repository;
  SplashModel _model = const SplashModel();
  Timer? _timer;
  bool _isNavigated = false;

  SplashProvider({SplashRepository? repository})
    : _repository = repository ?? SplashRepositoryImpl();

  SplashModel get model => _model;
  bool get isNavigated => _isNavigated;

  void startSplashTimer(VoidCallback onComplete) {
    if (_timer != null) return;

    _repository.initializeApp().then((updated) {
      _model = updated;
      notifyListeners();
    });

    _timer = Timer(_model.displayDuration, () {
      if (!_isNavigated) {
        _isNavigated = true;
        onComplete();
      }
    });
  }

  void cancelSplashTimer() {
    _timer?.cancel();
    _timer = null;
    _isNavigated = true;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
