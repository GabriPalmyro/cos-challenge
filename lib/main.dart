import 'package:cos_challenge/app/app_widget.dart';
import 'package:cos_challenge/app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureAppDependencies(GetIt.instance);
  runApp(const AppWidget());
}
