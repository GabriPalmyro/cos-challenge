part of 'car_search_cubit.dart';

sealed class CarSearchState extends Equatable {
  const CarSearchState();

  @override
  List<Object> get props => [];
}

final class CarSearchInitial extends CarSearchState {
  const CarSearchInitial({this.lastSearchResults = const []});
  final List<CarInfoModel> lastSearchResults;

  @override
  List<Object> get props => [lastSearchResults];
}

final class CarSearchLoading extends CarSearchState {
  const CarSearchLoading();

  @override
  List<Object> get props => [];
}

final class CarSearchLoaded extends CarSearchState {
  const CarSearchLoaded(this.carInfo);
  final CarInfoModel carInfo;

  @override
  List<Object> get props => [carInfo];
}

final class MultipleCarSearchLoaded extends CarSearchState {
  const MultipleCarSearchLoaded(this.carInfoList, this.lastSearchResults);
  final List<CarModel> carInfoList;
  final List<CarInfoModel> lastSearchResults;

  @override
  List<Object> get props => [carInfoList, lastSearchResults];
}

final class CarSearchError extends CarSearchState {
  const CarSearchError(this.error, {this.cachedResults = const []});
  final CarsErrors error;
  final List<CarInfoModel> cachedResults;

  @override
  List<Object> get props => [error, cachedResults];
}
