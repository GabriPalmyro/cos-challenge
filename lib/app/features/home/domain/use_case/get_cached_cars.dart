import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';

abstract class GetCachedCarsUseCase {
  Future<List<CarModel>> call();
}

class GetCachedCarsUseCaseImpl implements GetCachedCarsUseCase {
  GetCachedCarsUseCaseImpl(this._carDataSource);

  final CarDataSource _carDataSource;

  @override
  Future<List<CarModel>> call() async {
    try {
      return await _carDataSource.getCacheOnCache();
    } catch (e) {
      return [];
    }
  }
}
