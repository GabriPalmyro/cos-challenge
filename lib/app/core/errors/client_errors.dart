import 'package:cos_challenge/app/core/errors/failure.dart';

sealed class ClientErrors extends Failure {
  ClientErrors({required super.message});
}

class TimeoutError extends ClientErrors {
  TimeoutError({super.message = 'The request timed out.'});

  @override
  String toString() => 'TimeoutError: $message';
}

class NetworkError extends ClientErrors {
  NetworkError({super.message = 'Network error occurred.'});

  @override
  String toString() => 'NetworkError: $message';
}

class BadRequestError extends ClientErrors {
  BadRequestError({super.message = 'Bad request.'});

  @override
  String toString() => 'BadRequestError: $message';
}
