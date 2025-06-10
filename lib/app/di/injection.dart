import 'package:cos_challenge/app/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: r'$initAppDependencies')
Future<void> configureAppDependencies(
  GetIt getIt,
) async {
  getIt.$initAppDependencies();
}