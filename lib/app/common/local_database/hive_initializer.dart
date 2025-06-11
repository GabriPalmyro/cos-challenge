import 'package:cos_challenge/app/common/local_database/adapters/car_info_box.dart';
import 'package:cos_challenge/app/common/local_database/adapters/user_box.dart';
import 'package:cos_challenge/app/core/utils/cos_strings.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserBoxAdapter());
  Hive.registerAdapter(CarInfoBoxAdapter());

  await Hive.openBox<UserBox>(CosStrings.userBox);
  await Hive.openBox<CarInfoBox>(CosStrings.carBox);
}