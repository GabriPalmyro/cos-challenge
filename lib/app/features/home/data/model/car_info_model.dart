import 'package:cos_challenge/app/common/local_database/adapters/car_info_box.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:equatable/equatable.dart';

class CarInfoModel extends Equatable {
  const CarInfoModel({
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
  factory CarInfoModel.fromJson(Map<String, dynamic> json) {
    try {
      return CarInfoModel(
        id: json['id'],
        feedback: json['feedback'],
        valuatedAt: json['valuatedAt'],
        requestedAt: json['requestedAt'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        make: json['make'],
        model: json['model'],
        externalId: json['externalId'],
        sellerUser: json['_fk_sellerUser'],
        price: json['price'],
        positiveCustomerFeedback: json['positiveCustomerFeedback'],
        uuidAuction: json['_fk_uuid_auction'],
        inspectorRequestedAt: json['inspectorRequestedAt'],
        origin: json['origin'],
        estimationRequestId: json['estimationRequestId'],
      );
    } catch (e) {
      throw CarsDeserializationError();
    }
  }

  factory CarInfoModel.fromBox(CarInfoBox box) {
    return CarInfoModel(
      id: box.id,
      feedback: box.feedback,
      valuatedAt: box.valuatedAt,
      requestedAt: box.requestedAt,
      createdAt: box.createdAt,
      updatedAt: box.updatedAt,
      make: box.make,
      model: box.model,
      externalId: box.externalId,
      sellerUser: box.sellerUser,
      price: box.price,
      positiveCustomerFeedback: box.positiveCustomerFeedback,
      uuidAuction: box.uuidAuction,
      inspectorRequestedAt: box.inspectorRequestedAt,
      origin: box.origin,
      estimationRequestId: box.estimationRequestId,
    );
  }

  final int id;
  final String feedback;
  final String valuatedAt;
  final String requestedAt;
  final String createdAt;
  final String updatedAt;
  final String make;
  final String model;
  final String externalId;
  final String sellerUser;
  final int price;
  final bool positiveCustomerFeedback;
  final String uuidAuction;
  final String inspectorRequestedAt;
  final String origin;
  final String estimationRequestId;

  CarInfoBox toBox() {
    return CarInfoBox(
      id: id,
      feedback: feedback,
      valuatedAt: valuatedAt,
      requestedAt: requestedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      make: make,
      model: model,
      externalId: externalId,
      sellerUser: sellerUser,
      price: price,
      positiveCustomerFeedback: positiveCustomerFeedback,
      uuidAuction: uuidAuction,
      inspectorRequestedAt: inspectorRequestedAt,
      origin: origin,
      estimationRequestId: estimationRequestId,
    );
  }
  

  CarInfoModel copyWith({
    int? id,
    String? feedback,
    String? valuatedAt,
    String? requestedAt,
    String? createdAt,
    String? updatedAt,
    String? make,
    String? model,
    String? externalId,
    String? sellerUser,
    int? price,
    bool? positiveCustomerFeedback,
    String? uuidAuction,
    String? inspectorRequestedAt,
    String? origin,
    String? estimationRequestId,
  }) {
    return CarInfoModel(
      id: id ?? this.id,
      feedback: feedback ?? this.feedback,
      valuatedAt: valuatedAt ?? this.valuatedAt,
      requestedAt: requestedAt ?? this.requestedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      make: make ?? this.make,
      model: model ?? this.model,
      externalId: externalId ?? this.externalId,
      sellerUser: sellerUser ?? this.sellerUser,
      price: price ?? this.price,
      positiveCustomerFeedback:
          positiveCustomerFeedback ?? this.positiveCustomerFeedback,
      uuidAuction: uuidAuction ?? this.uuidAuction,
      inspectorRequestedAt:
          inspectorRequestedAt ?? this.inspectorRequestedAt,
      origin: origin ?? this.origin,
      estimationRequestId:
          estimationRequestId ?? this.estimationRequestId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        feedback,
        valuatedAt,
        requestedAt,
        createdAt,
        updatedAt,
        make,
        model,
        externalId,
        sellerUser,
        price,
        positiveCustomerFeedback,
        uuidAuction,
        inspectorRequestedAt,
        origin,
        estimationRequestId,
      ];
}
