class PasswordRegEx {
  PasswordRegEx._();
  static final RegExp passwordNoNumber = RegExp(r'[0-9]');
  static final RegExp passwordNoLetter = RegExp(r'[a-zA-Z]');
  static final RegExp passwordTooSimple = RegExp(r'^[a-zA-Z0-9]+$');
}

class PasswordValidator {
  PasswordValidator._();

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(PasswordRegEx.passwordNoNumber)) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(PasswordRegEx.passwordNoLetter)) {
      return 'Password must contain at least one letter';
    }
    if (PasswordRegEx.passwordTooSimple.hasMatch(value)) {
      return 'Password is too simple, use a mix of letters, numbers, and symbols';
    }
    return null;
  }
}