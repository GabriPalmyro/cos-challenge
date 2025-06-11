import 'package:cos_challenge/app/core/errors/failure.dart';

sealed class UsersErrors extends Failure {
  const UsersErrors({required super.message});
}

class UserNotFoundError extends UsersErrors {
  const UserNotFoundError({super.message = 'User not found.'});

  @override
  String toString() => 'UserNotFoundError: $message';
}

class InvalidCredentialsError extends UsersErrors {
  const InvalidCredentialsError({super.message = 'Invalid credentials.'});

  @override
  String toString() => 'InvalidCredentialsError: $message';
}