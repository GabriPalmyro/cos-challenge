import 'package:cos_challenge/app/core/errors/failure.dart';

sealed class CarsErrors extends Failure {
  CarsErrors({required super.message});
}

class CarsSearchTimeoutException extends CarsErrors {
  CarsSearchTimeoutException({super.message = 'Request timeout occurred.'});

  @override
  String toString() => 'CarsSearchTimeoutException: $message';
}

class CarsClientException extends CarsErrors {
  CarsClientException({super.message = 'Client error occurred.'});

  @override
  String toString() => 'CarsClientException: $message';
}

class CarsNotFoundError extends CarsErrors {
  CarsNotFoundError({super.message = 'Car not found.'});

  @override
  String toString() => 'CarsNotFoundError: $message';
}
