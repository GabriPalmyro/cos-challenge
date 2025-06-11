import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';

abstract class CarSearchResult {}

class CarSearchSuccess implements CarSearchResult {
  CarSearchSuccess(this.carInfo);
  final CarInfoModel carInfo;
}

class CarMultipleChoices implements CarSearchResult {
  CarMultipleChoices(this.carsList, {this.lastSearchResults = const []});
  final List<CarModel> carsList;
  final List<CarInfoModel> lastSearchResults;
}

class CarSearchFailure implements CarSearchResult {
  CarSearchFailure(this.error, {this.cachedResults = const []});

  final List<CarInfoModel> cachedResults;
  final CarsErrors error;
}
