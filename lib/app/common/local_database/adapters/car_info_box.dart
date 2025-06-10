import 'package:hive/hive.dart';

part 'car_info_box.g.dart';

@HiveType(typeId: 1)
class CarInfoBox extends HiveObject {
  CarInfoBox({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  @HiveField(0)
  final String make;

  @HiveField(1)
  final String model;

  @HiveField(2)
  final String containerName;

  @HiveField(3)
  final int similarity;

  @HiveField(4)
  final String externalId;
}
