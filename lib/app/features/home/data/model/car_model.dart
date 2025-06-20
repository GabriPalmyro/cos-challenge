import 'package:cos_challenge/app/core/errors/cars_errors.dart';
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
    try {
      return CarModel(
        make: json['make'] as String,
        model: json['model'] as String,
        containerName: json['containerName'] as String,
        similarity: json['similarity'] as int,
        externalId: json['externalId'] as String,
      );
    } catch (e) {
      throw const CarsDeserializationError();
    }
  }

  CarModel copyWith({
    String? make,
    String? model,
    String? containerName,
    int? similarity,
    String? externalId,
  }) {
    return CarModel(
      make: make ?? this.make,
      model: model ?? this.model,
      containerName: containerName ?? this.containerName,
      similarity: similarity ?? this.similarity,
      externalId: externalId ?? this.externalId,
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
