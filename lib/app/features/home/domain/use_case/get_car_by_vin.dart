import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart';

abstract class GetCarByVinUseCase {
  Future<CarSearchResult> call(String vin);
}

class GetCarByVinUseCaseImpl implements GetCarByVinUseCase {
  GetCarByVinUseCaseImpl(
    this._carSearchRepository,
    this._carDataSource,
    this._authDataSource,
  );

  final CarSearchRepository _carSearchRepository;
  final CarDataSource _carDataSource;
  final AuthDataSource _authDataSource;

  @override
  Future<CarSearchResult> call(String vin) async {
    try {
      final user = await _authDataSource.getCurrentUser();
      final result = await _carSearchRepository.getCarByVin(vin, user.email);

      if (result is CarMultipleChoices) {
        _saveNewCarToCache(result.carsList);
        return result;
      }

      if (result is CarSearchFailure) {
        final cacheList = await _carDataSource.getCacheOnCache();
        if (cacheList.isNotEmpty) {
          return CarMultipleChoices(cacheList);
        } else {
          return result;
        }
      }

      return result;
    } catch (e) {
      final cacheList = await _carDataSource.getCacheOnCache();
      if (cacheList.isNotEmpty) {
        return CarMultipleChoices(cacheList);
      } else {
        return CarSearchFailure(CarsNotFoundError());
      }
    }
  }

  Future<void> _saveNewCarToCache(List<CarModel> cars) async {
    await _carDataSource.deleteCacheOnCache();
    _carDataSource.saveCacheOnCache(cars);
  }
}
