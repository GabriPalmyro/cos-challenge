import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';

abstract class CarDataSource {
  Future<List<CarInfoModel>> getCacheOnCache();
  Future<void> saveCacheOnCache(CarInfoModel car);
  Future<void> deleteCacheOnCache();
}