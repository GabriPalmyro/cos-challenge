import 'package:cos_challenge/app/common/client/cos_client.dart';

class VinRegEx {
  VinRegEx._();
  static final RegExp vinFormat = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
  static final RegExp invalidChars = RegExp(r'[IOQ]');
}

class VinValidator {
  VinValidator._();

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'VIN cannot be empty';
    }

    if (value.length != CosChallenge.vinLength) {
      return 'VIN must be exactly 17 characters long';
    }

    if (VinRegEx.invalidChars.hasMatch(value)) {
      return 'VIN cannot contain I, O, or Q characters';
    }

    if (!VinRegEx.vinFormat.hasMatch(value.toUpperCase())) {
      return 'VIN contains invalid characters';
    }

    return null;
  }
}