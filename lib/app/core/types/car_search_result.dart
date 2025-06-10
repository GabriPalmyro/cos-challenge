import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';

abstract class CarSearchResult {}

class CarSearchSuccess implements CarSearchResult {
  CarSearchSuccess(this.carInfo);
  final CarInfoModel carInfo;
}

class CarMultipleChoices implements CarSearchResult {
  CarMultipleChoices(this.carsList);
  final List<CarModel> carsList;
}

class CarSearchFailure implements CarSearchResult {
  CarSearchFailure(this.error);
  final CarsErrors error;
}
