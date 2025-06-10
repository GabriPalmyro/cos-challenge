import 'package:cos_challenge/app/core/types/car_search_result.dart';

abstract class CarSearchRepository {
  Future<CarSearchResult> getCarByVin(String vin, String userEmail);
}