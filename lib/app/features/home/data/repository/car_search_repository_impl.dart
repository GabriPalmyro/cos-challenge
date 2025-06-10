import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cos_challenge/app/common/client/cos_client.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart';
import 'package:http/http.dart';

class CarSearchRepositoryImpl implements CarSearchRepository {
  @override
  Future<CarSearchResult> getCarByVin(String vin, String userEmail) async {
    try {
      final response = await CosChallenge.httpClient.get(
        Uri.https('anyUrl'),
        headers: {
          CosChallenge.user: userEmail,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        return CarSearchSuccess(CarInfoModel.fromJson(json));
      } else if (response.statusCode == HttpStatus.multipleChoices) {
        final jsonList = jsonDecode(response.body) as List;
        final cars = jsonList.map((e) => CarModel.fromJson(e)).toList();
        return CarMultipleChoices(cars);
      } else {
        final error = jsonDecode(response.body);
        return CarSearchFailure(
          CarsNotFoundError(
            message: error['message'] ?? 'Unknown server error',
          ),
        );
      }
    } on TimeoutException catch (_) {
      throw CarsSearchTimeoutException();
    } on ClientException catch (_) {
      throw CarsClientException();
    } catch (e) {
      throw CarsNotFoundError();
    }
  }
}