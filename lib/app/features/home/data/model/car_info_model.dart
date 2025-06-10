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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feedback': feedback,
      'valuatedAt': valuatedAt,
      'requestedAt': requestedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'make': make,
      'model': model,
      'externalId': externalId,
      '_fk_sellerUser': sellerUser,
      'price': price,
      'positiveCustomerFeedback': positiveCustomerFeedback,
      '_fk_uuid_auction': uuidAuction,
      'inspectorRequestedAt': inspectorRequestedAt,
      'origin': origin,
      'estimationRequestId': estimationRequestId,
    };
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
