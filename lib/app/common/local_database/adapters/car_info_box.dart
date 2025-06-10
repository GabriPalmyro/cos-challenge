import 'package:hive/hive.dart';

part 'car_info_box.g.dart';

@HiveType(typeId: 1)
class CarInfoBox extends HiveObject {
  CarInfoBox({
    required this.vin,
    required this.model,
    required this.price,
    required this.uuid,
    required this.positiveFeedback,
  });

  @HiveField(0)
  final String vin;

  @HiveField(1)
  final String model;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String uuid;

  @HiveField(4)
  final bool positiveFeedback;
}
