import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/repository/car_search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class MockHttpClient extends Mock implements http.BaseClient {}

void main() {
  late CarSearchRepositoryImpl repository;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = CarSearchRepositoryImpl(httpClient: mockHttpClient);
  });

  group('CarSearchRepositoryImpl Test |', () {
    const testVin = 'TEST123456789';
    const testUserEmail = 'test@example.com';

    test('should return CarSearchSuccess when response is OK', () async {
      // Arrange
      final mockResponse = http.Response(
        carInfoResponse,
        HttpStatus.ok,
      );
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getCarByVin(testVin, testUserEmail);

      // Assert
      expect(result, isA<CarSearchSuccess>());
    });

    test('should return CarMultipleChoices when response is multipleChoices', () async {
      // Arrange
      final mockResponse = http.Response(
        multipleOptionResponse,
        HttpStatus.multipleChoices,
      );
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getCarByVin(testVin, testUserEmail);

      // Assert
      expect(result, isA<CarMultipleChoices>());
    });

    test('should throw CarMaintenanceDelayException when response is badRequest', () async {
      // Arrange
      final mockResponse = http.Response(
        jsonEncode({
          'params': {'delaySeconds': '30'},
        }),
        HttpStatus.badRequest,
      );
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(isA<CarMaintenanceDelayException>()),
      );
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(
          predicate<CarMaintenanceDelayException>(
            (e) => e.delayInSeconds == 30,
          ),
        ),
      );
    });

    test('should return CarSearchFailure for other status codes', () async {
      // Arrange
      final mockResponse = http.Response(
        jsonEncode({'message': 'Car not found'}),
        HttpStatus.notFound,
      );
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getCarByVin(testVin, testUserEmail);

      // Assert
      expect(result, isA<CarSearchFailure>());
    });

    test('should throw CarsDeserializationError when JSON parsing fails for OK response', () async {
      // Arrange
      final mockResponse = http.Response('invalid json', HttpStatus.ok);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(isA<CarsDeserializationError>()),
      );
    });

    test('should throw CarsDeserializationError when JSON parsing fails for multipleChoices', () async {
      // Arrange
      final mockResponse = http.Response('invalid json', HttpStatus.multipleChoices);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(isA<CarsDeserializationError>()),
      );
    });

    test('should throw CarsSearchTimeoutException when TimeoutException occurs', () async {
      // Arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenThrow(TimeoutException('Timeout', const Duration(seconds: 30)));

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(isA<CarsSearchTimeoutException>()),
      );
    });

    test('should throw CarsClientException when ClientException occurs', () async {
      // Arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenThrow(http.ClientException('Network error'));

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(isA<CarsClientException>()),
      );
    });

    test('should rethrow CarsErrors', () async {
      // Arrange
      const customError = CarsDeserializationError();
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenThrow(customError);

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(customError),
      );
    });

    test('should handle badRequest with invalid delaySeconds', () async {
      // Arrange
      final mockResponse = http.Response(
        jsonEncode({
          'params': {'delaySeconds': 'invalid'},
        }),
        HttpStatus.badRequest,
      );
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers'))).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => repository.getCarByVin(testVin, testUserEmail),
        throwsA(
          predicate<CarMaintenanceDelayException>(
            (e) => e.delayInSeconds == 0,
          ),
        ),
      );
    });
  });
}
