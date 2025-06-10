import 'package:cos_challenge/app/features/home/data/model/car_model.dart';

abstract class CarDataSource {
  Future<List<CarModel>> getCacheOnCache();
  Future<void> saveCacheOnCache(List<CarModel> cars);
  Future<void> deleteCacheOnCache();
}