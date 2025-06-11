import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:equatable/equatable.dart';

sealed class CarSearchResult extends Equatable {
  const CarSearchResult();

  @override
  List<Object?> get props => [];
}

class CarSearchSuccess extends CarSearchResult {
  const CarSearchSuccess(this.carInfo);
  final CarInfoModel carInfo;
  
  @override
  List<Object?> get props => [carInfo];
}

class CarMultipleChoices extends CarSearchResult {
  const CarMultipleChoices(this.carsList, {this.lastSearchResults = const []});
  final List<CarModel> carsList;
  final List<CarInfoModel> lastSearchResults;

  @override
  List<Object?> get props => [carsList, lastSearchResults];
}

class CarSearchFailure extends CarSearchResult {
  const CarSearchFailure(this.error, {this.cachedResults = const []});

  final List<CarInfoModel> cachedResults;
  final CarsErrors error;

  @override
  List<Object?> get props => [error, cachedResults];
}
