class EmailRegEx {
  EmailRegEx._();
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}

class EmailValidator {
  EmailValidator._();

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!EmailRegEx.email.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
