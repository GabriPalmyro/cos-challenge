import 'package:cos_challenge/app/common/local_database/boxes.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';

class CarLocalDataSourceImpl implements CarDataSource {
  @override
  Future<List<CarModel>> getCacheOnCache() async {
    final carBox = Boxes.carBox;
    try {
      final cars = carBox.values.toList();
      return Future.value(cars.map((car) => CarModel.fromBox(car)).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveCacheOnCache(List<CarModel> cars) async {
    final carBox = Boxes.carBox;
    try {
      await carBox.clear();
      await carBox.addAll(cars.map((car) => car.toBox()));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCacheOnCache() {
    final carBox = Boxes.carBox;
    try {
      return carBox.clear();
    } catch (e) {
      rethrow;
    }
  }
}
