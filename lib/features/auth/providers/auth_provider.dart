import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/models/user_model.dart';
import '../../../shared/models/user_role.dart';
import '../models/auth_state_model.dart';
import '../repositories/auth_repository.dart';

/// Pure Stateless architecture with Provider. Zero setState().
class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  late final List<TextEditingController> otpControllers;
  late final List<FocusNode> otpFocusNodes;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  AuthProvider({AuthRepository? repository})
      : _repository = repository ?? AuthRepositoryImpl() {
    nameController = TextEditingController(text: _state.fullName);
    emailController = TextEditingController(text: _state.email);
    phoneController = TextEditingController(text: _state.phone);
    otpControllers = List.generate(4, (_) => TextEditingController());
    otpFocusNodes = List.generate(4, (index) {
      final node = FocusNode();
      node.onKeyEvent = (fNode, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
          if (otpControllers[index].text.isEmpty && index > 0) {
            otpFocusNodes[index - 1].requestFocus();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      };
      return node;
    });
  }

  // State Container
  AuthStateModel _state = const AuthStateModel();
  AuthStateModel get state => _state;

  SignupStep get currentStep => _state.currentStep;
  String get fullName => _state.fullName;
  String get email => _state.email;
  String get phone => _state.phone;
  bool get termsAccepted => _state.termsAgreed;
  List<String> get otpDigits => _state.otpDigits;
  int get resendCountdown => _state.resendCountdown;
  bool get canResendOtp => _state.canResendOtp;
  bool get isLoading => _state.isLoading;
  String? get errorMessage => _state.errorMessage;
  UserRole get selectedRole => _state.selectedRole;
  UserModel get currentUser => _state.verifiedUser ?? UserModel.defaultUser;

  Timer? _resendTimer;
  Timer? _redirectTimer;
  Timer? _splashTimer;

  int _redirectCountdown = 5;
  int get redirectCountdown => _redirectCountdown;

  void startSplashTimer(VoidCallback onNavigate) {
    _splashTimer?.cancel();
    _splashTimer = Timer(const Duration(seconds: 3), onNavigate);
  }

  void cancelSplashTimer() {
    _splashTimer?.cancel();
    _splashTimer = null;
  }

  void selectRole(UserRole role) {
    if (_state.selectedRole != role) {
      _state = _state.copyWith(selectedRole: role);
      notifyListeners();
    }
  }

  void updateFullName(String val) {
    _state = _state.copyWith(fullName: val, errorMessage: null);
    notifyListeners();
  }

  void updateEmail(String val) {
    _state = _state.copyWith(email: val, errorMessage: null);
    notifyListeners();
  }

  void updatePhone(String val) {
    _state = _state.copyWith(phone: val, errorMessage: null);
    notifyListeners();
  }

  void toggleTerms(bool? val) {
    _state = _state.copyWith(termsAgreed: val ?? false);
    notifyListeners();
  }

  Future<bool> sendOtp() async {
    if (_state.fullName.trim().isEmpty || _state.email.trim().isEmpty || _state.phone.trim().isEmpty) {
      _state = _state.copyWith(errorMessage: 'Please fill in Name, Email, and Contact fields.');
      notifyListeners();
      return false;
    }

    if (!_state.termsAgreed) {
      _state = _state.copyWith(errorMessage: 'Please accept the Terms of Service to proceed.');
      notifyListeners();
      return false;
    }

    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      await _repository.sendOtp(phone: _state.phone, email: _state.email);
      for (final c in otpControllers) {
        c.clear();
      }
      _state = _state.copyWith(
        isLoading: false,
        currentStep: SignupStep.otp,
        resendCountdown: 30,
        canResendOtp: false,
        otpDigits: const ['', '', '', ''],
      );
      _startResendTimer();
      notifyListeners();

      // Automatically focus first box matching source_nbi signup.js
      Future.delayed(const Duration(milliseconds: 100), () {
        if (otpFocusNodes.isNotEmpty) {
          otpFocusNodes[0].requestFocus();
        }
      });

      return true;
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to send OTP. Please try again.',
      );
      notifyListeners();
      return false;
    }
  }

  void handleOtpInput(int index, String val) {
    if (val.length > 1) {
      // Pasted or multi-digit input
      final digits = val.replaceAll(RegExp(r'\D'), '').split('');
      for (int i = 0; i < digits.length && (index + i) < 4; i++) {
        otpControllers[index + i].text = digits[i];
      }
      final target = (index + digits.length).clamp(0, 3);
      otpFocusNodes[target].requestFocus();
    } else if (val.isNotEmpty) {
      if (index < 3) {
        otpFocusNodes[index + 1].requestFocus();
      }
    }
    final updatedList = otpControllers.map((c) => c.text).toList();
    _state = _state.copyWith(otpDigits: updatedList, errorMessage: null);
    notifyListeners();
  }

  void updateOtpDigit(int index, String digit) {
    if (index >= 0 && index < 4) {
      if (otpControllers[index].text != digit) {
        otpControllers[index].text = digit;
      }
      handleOtpInput(index, digit);
    }
  }

  Future<bool> verifyOtp() async {
    final enteredOtp = otpControllers.map((c) => c.text).join();
    if (enteredOtp.length < 4) {
      _state = _state.copyWith(errorMessage: 'Please enter a valid 4-digit OTP code.');
      notifyListeners();
      return false;
    }

    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final user = await _repository.verifyOtp(
        phone: _state.phone,
        otpDigits: otpControllers.map((c) => c.text).toList(),
        role: _state.selectedRole,
      );
      final verifiedUser = user.copyWith(
        fullName: _state.fullName.trim().isNotEmpty ? _state.fullName.trim() : user.fullName,
        email: _state.email.trim().isNotEmpty ? _state.email.trim() : user.email,
        phone: _state.phone.trim().isNotEmpty ? _state.phone.trim() : user.phone,
        role: _state.selectedRole,
      );
      _state = _state.copyWith(
        isLoading: false,
        currentStep: SignupStep.success,
        verifiedUser: verifiedUser,
      );
      _cancelTimers();
      _startRedirectCountdown();
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Verification failed. Please check the OTP.',
      );
      notifyListeners();
      return false;
    }
  }

  void resendOtp() {
    if (!_state.canResendOtp) return;
    for (final c in otpControllers) {
      c.clear();
    }
    _state = _state.copyWith(
      resendCountdown: 30,
      canResendOtp: false,
      otpDigits: const ['', '', '', ''],
      errorMessage: null,
    );
    notifyListeners();
    _startResendTimer();
    _repository.sendOtp(phone: _state.phone, email: _state.email);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (otpFocusNodes.isNotEmpty) {
        otpFocusNodes[0].requestFocus();
      }
    });
  }

  void goToStep1() {
    for (final c in otpControllers) {
      c.clear();
    }
    _cancelTimers();
    _state = _state.copyWith(
      currentStep: SignupStep.form,
      otpDigits: const ['', '', '', ''],
      errorMessage: null,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    await _repository.logout();
    _state = const AuthStateModel();
    for (final c in otpControllers) {
      c.clear();
    }
    _cancelTimers();
    notifyListeners();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.resendCountdown > 1) {
        _state = _state.copyWith(resendCountdown: _state.resendCountdown - 1);
        notifyListeners();
      } else {
        _state = _state.copyWith(resendCountdown: 0, canResendOtp: true);
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void _startRedirectCountdown() {
    _redirectCountdown = 5;
    _redirectTimer?.cancel();
    _redirectTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_redirectCountdown > 1) {
        _redirectCountdown--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void _cancelTimers() {
    _resendTimer?.cancel();
    _resendTimer = null;
    _redirectTimer?.cancel();
    _redirectTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    _splashTimer?.cancel();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }
}
