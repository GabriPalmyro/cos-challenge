import 'package:cos_challenge/app/common/local_database/adapters/car_info_box.dart';
import 'package:cos_challenge/app/common/local_database/adapters/user_box.dart';
import 'package:cos_challenge/app/core/utils/cos_strings.dart';
import 'package:cos_challenge/app/di/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> configureIntegrationApp() async {
  await configureAppDependencies(GetIt.instance);
  await initHiveForTests();
}

Future<void> initHiveForTests() async {
  await Hive.initFlutter();

  // Only register adapters if they haven't been registered yet
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserBoxAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CarInfoBoxAdapter());
  }

  // Open boxes if they're not already open
  if (!Hive.isBoxOpen(CosStrings.userBox)) {
    await Hive.openBox<UserBox>(CosStrings.userBox);
  }
  if (!Hive.isBoxOpen(CosStrings.carBox)) {
    await Hive.openBox<CarInfoBox>(CosStrings.carBox);
  }
}
