import 'package:cos_challenge/app/common/local_database/adapters/car_info_box.dart';
import 'package:cos_challenge/app/common/local_database/adapters/user_box.dart';
import 'package:cos_challenge/app/core/utils/cos_strings.dart';
import 'package:hive/hive.dart';

class Boxes {
  Boxes._();

  static Box<UserBox> get userBox => Hive.box<UserBox>(CosStrings.userBox);
  static Box<CarInfoBox> get carBox => Hive.box<CarInfoBox>(CosStrings.carBox);
}