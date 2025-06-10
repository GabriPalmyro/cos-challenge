import 'package:cos_challenge/app/common/local_database/adapters/user_box.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.name,
    required this.email,
  });
  
  factory UserModel.fromBox(UserBox box) {
    return UserModel(
      name: box.name,
      email: box.email,
    );
  }

  final String name;
  final String email;

  UserModel copyWith({
    String? name,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  UserBox toBox() {
    return UserBox(
      name: name,
      email: email,
    );
  }

  @override
  List<Object?> get props => [name, email];
}
