import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cos_challenge/app/common/client/cos_client.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart';
import 'package:http/http.dart' as http;

class CarSearchRepositoryImpl implements CarSearchRepository {
  CarSearchRepositoryImpl({http.BaseClient? httpClient}) : _httpClient = httpClient ?? CosChallenge.httpClient;

  final http.BaseClient _httpClient;

  @override
  Future<CarSearchResult> getCarByVin(String vin, String userEmail) async {
    try {
      final response = await _httpClient.get(
        Uri.https('anyUrl'),
        headers: {
          CosChallenge.user: userEmail,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        try {
          final json = jsonDecode(response.body);
          return CarSearchSuccess(CarInfoModel.fromJson(json));
        } catch (_) {
          throw const CarsDeserializationError();
        }
      } else if (response.statusCode == HttpStatus.multipleChoices) {
        try {
          final jsonList = jsonDecode(response.body) as List;
          final cars = jsonList.map((e) => CarModel.fromJson(e)).toList();
          return CarMultipleChoices(cars);
        } catch (_) {
          throw const CarsDeserializationError();
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        final json = jsonDecode(response.body);
        throw CarMaintenanceDelayException(
          delayInSeconds: int.tryParse(json['params']['delaySeconds']) ?? 0,
        );
      } else {
        final error = jsonDecode(response.body);
        return CarSearchFailure(
          CarsNotFoundError(
            message: error['message'] ?? 'Unknown server error',
          ),
        );
      }
    } on TimeoutException catch (_) {
      throw const CarsSearchTimeoutException();
    } on http.ClientException catch (_) {
      throw const CarsClientException();
    } on CarsErrors catch (_) {
      rethrow;
    }
  }
}
