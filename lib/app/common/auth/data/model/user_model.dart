import 'package:cos_challenge/app/common/local_database/adapters/user_box.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
  });
  
  factory UserModel.fromBox(UserBox box) {
    return UserModel(
      id: box.id,
      email: box.email,
    );
  }

  final String id;
  final String email;

  UserModel copyWith({
    String? id,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  UserBox toBox() {
    return UserBox(
      id: id,
      email: email,
    );
  }

  @override
  List<Object?> get props => [id, email];
}
