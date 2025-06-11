import 'package:cos_challenge/app/core/errors/failure.dart';

sealed class CarsErrors extends Failure {
  CarsErrors({required super.message});
}

class CarsSearchTimeoutException extends CarsErrors {
  CarsSearchTimeoutException({super.message = 'The car search request timed out. Please try again later'});

  @override
  String toString() => 'CarsSearchTimeoutException: $message';
}

class CarMaintenanceDelayException extends CarsErrors {
  CarMaintenanceDelayException({
    required this.delayInSeconds,
  }) : super(message: 'The car search service is currently under maintenance. Please try again later in ${delayInSeconds ?? 0} seconds.');

  final int? delayInSeconds;

  @override
  String toString() => 'CarMaintenceDelayException: $message';
}

class CarsClientException extends CarsErrors {
  CarsClientException({super.message = 'Client error occurred while fetching car data.'});

  @override
  String toString() => 'CarsClientException: $message';
}

class CarsNotFoundError extends CarsErrors {
  CarsNotFoundError({super.message = 'No car found with this VIN'});

  @override
  String toString() => 'CarsNotFoundError: $message';
}

class CarsDeserializationError extends CarsErrors {
  CarsDeserializationError({super.message = 'There was an error deserializing the car data. Please try again later'});

  @override
  String toString() => 'CarsDeserializationError: $message';
}
