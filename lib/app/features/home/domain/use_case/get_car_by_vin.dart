import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
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
      final lastResults = await _carDataSource.getCacheOnCache();

      if (result is CarMultipleChoices) {
        return CarMultipleChoices(
          result.carsList..sort(
            (a, b) => b.similarity.compareTo(a.similarity),
          ),
          lastSearchResults: lastResults,
        );
      }

      if (result is CarSearchSuccess) {
        await _carDataSource.saveCacheOnCache(result.carInfo);
        return result;
      }

      if (result is CarSearchFailure) {
        if (lastResults.isNotEmpty) {
          return CarSearchFailure(
            result.error,
            cachedResults: lastResults,
          );
        } else {
          return result;
        }
      }

      return result;
    } catch (e) {
      final cacheList = await _carDataSource.getCacheOnCache();

      return CarSearchFailure(
        e is CarsErrors ? e : const CarsNotFoundError(),
        cachedResults: cacheList,
      );
    }
  }
}
