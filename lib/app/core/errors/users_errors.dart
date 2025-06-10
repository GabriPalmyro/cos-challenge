import 'package:cos_challenge/app/core/errors/failure.dart';

sealed class UsersErrors extends Failure {
  UsersErrors({required super.message});
}

class UserNotFoundError extends UsersErrors {
  UserNotFoundError({super.message = 'User not found.'});

  @override
  String toString() => 'UserNotFoundError: $message';
}

class InvalidCredentialsError extends UsersErrors {
  InvalidCredentialsError({super.message = 'Invalid credentials.'});

  @override
  String toString() => 'InvalidCredentialsError: $message';
}