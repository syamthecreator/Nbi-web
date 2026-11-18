/// Form and input validation helpers for the NBI application.
class AppValidators {
  AppValidators._();

  /// Validates required text fields.
  static String? requiredField(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates email format.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates 10-digit Indian phone number.
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 10) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  /// Validates OTP format (4 digits).
  static String? otp(List<String> digits) {
    if (digits.length != 4 || digits.any((d) => d.trim().isEmpty)) {
      return 'Please enter the complete 4-digit OTP';
    }
    return null;
  }
}
