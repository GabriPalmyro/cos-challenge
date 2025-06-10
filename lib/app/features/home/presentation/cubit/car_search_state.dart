part of 'car_search_cubit.dart';

sealed class CarSearchState extends Equatable {
  const CarSearchState();

  @override
  List<Object> get props => [];
}

final class CarSearchInitial extends CarSearchState {
  const CarSearchInitial();

  @override
  List<Object> get props => [];
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
  const MultipleCarSearchLoaded(this.carInfoList);
  final List<CarModel> carInfoList;

  @override
  List<Object> get props => [carInfoList];
}

final class CarSearchError extends CarSearchState {
  const CarSearchError(this.error);
  final CarsErrors error;

  @override
  List<Object> get props => [error];
}
