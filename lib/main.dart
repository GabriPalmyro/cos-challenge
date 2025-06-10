import 'package:cos_challenge/app/app_widget.dart';
import 'package:cos_challenge/app/common/local_database/hive_initializer.dart';
import 'package:cos_challenge/app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureAppDependencies(GetIt.instance);
  await initHive();
  runApp(const AppWidget());
}
