import 'package:cos_challenge/app/core/errors/failure.dart';

sealed class ClientErrors extends Failure {
  const ClientErrors({required super.message});
}

class TimeoutError extends ClientErrors {
  const TimeoutError({super.message = 'The request timed out.'});

  @override
  String toString() => 'TimeoutError: $message';
}

class NetworkError extends ClientErrors {
  const NetworkError({super.message = 'Network error occurred.'});

  @override
  String toString() => 'NetworkError: $message';
}

class BadRequestError extends ClientErrors {
  const BadRequestError({super.message = 'Bad request.'});

  @override
  String toString() => 'BadRequestError: $message';
}
