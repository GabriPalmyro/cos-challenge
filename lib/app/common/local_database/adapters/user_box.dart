import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox extends HiveObject {
  UserBox({
    required this.id,
    required this.email,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;
}
