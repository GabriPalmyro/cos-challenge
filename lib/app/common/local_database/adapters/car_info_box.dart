import 'package:hive/hive.dart';

part 'car_info_box.g.dart';

@HiveType(typeId: 1)
class CarInfoBox extends HiveObject {
  CarInfoBox({
    required this.id,
    required this.feedback,
    required this.valuatedAt,
    required this.requestedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.make,
    required this.model,
    required this.externalId,
    required this.sellerUser,
    required this.price,
    required this.positiveCustomerFeedback,
    required this.uuidAuction,
    required this.inspectorRequestedAt,
    required this.origin,
    required this.estimationRequestId,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String feedback;

  @HiveField(2)
  final String valuatedAt;

  @HiveField(3)
  final String requestedAt;

  @HiveField(4)
  final String createdAt;

  @HiveField(5)
  final String updatedAt;

  @HiveField(6)
  final String make;

  @HiveField(7)
  final String model;

  @HiveField(8)
  final String externalId;

  @HiveField(9)
  final String sellerUser;

  @HiveField(10)
  final int price;

  @HiveField(11)
  final bool positiveCustomerFeedback;

  @HiveField(12)
  final String uuidAuction;

  @HiveField(13)
  final String inspectorRequestedAt;

  @HiveField(14)
  final String origin;

  @HiveField(15)
  final String estimationRequestId;
}
