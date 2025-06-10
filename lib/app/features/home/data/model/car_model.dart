import 'package:cos_challenge/app/common/local_database/adapters/car_info_box.dart';
import 'package:equatable/equatable.dart';

class CarModel extends Equatable {
  const CarModel({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      make: json['make'] as String,
      model: json['model'] as String,
      containerName: json['containerName'] as String,
      similarity: json['similarity'] as int,
      externalId: json['externalId'] as String,
    );
  }

  factory CarModel.fromBox(CarInfoBox box) {
    return CarModel(
      make: box.make,
      model: box.model,
      containerName: box.containerName,
      similarity: box.similarity,
      externalId: box.externalId,
    );
  }

  CarInfoBox toBox() {
    return CarInfoBox(
      make: make,
      model: model,
      containerName: containerName,
      similarity: similarity,
      externalId: externalId,
    );
  }

  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  @override
  List<Object?> get props => [make, model, containerName, similarity, externalId];
}
