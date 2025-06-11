import 'package:bloc/bloc.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_cached_cars.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_car_by_vin.dart';
import 'package:equatable/equatable.dart';

part 'car_search_state.dart';

class CarSearchCubit extends Cubit<CarSearchState> {
  CarSearchCubit(
    this._getCarByVinUseCase,
    this._getCachedCarsUseCase,
  ) : super(const CarSearchInitial());

  final GetCarByVinUseCase _getCarByVinUseCase;
  final GetCachedCarsUseCase _getCachedCarsUseCase;

  Future<void> searchCarByVin(String vin) async {
    try {
      emit(const CarSearchLoading());
      final result = await _getCarByVinUseCase.call(vin);

      if (result is CarSearchSuccess) {
        emit(CarSearchLoaded(result.carInfo));
      } else if (result is CarMultipleChoices) {
        emit(MultipleCarSearchLoaded(result.carsList, result.lastSearchResults));
      } else if (result is CarSearchFailure) {
        emit(CarSearchError(result.error, cachedResults: result.cachedResults));
      } else {
        emit(CarSearchError(CarsNotFoundError()));
      }
    } catch (e) {
      emit(CarSearchError(CarsNotFoundError()));
    }
  }

  Future<void> loadCachedCars() async {
    final cachedCars = await _getCachedCarsUseCase.call();
    emit(CarSearchInitial(lastSearchResults: cachedCars));
  }
}
