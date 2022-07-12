import 'package:flutter_tech_task/services/api_service.dart';
import 'package:flutter_tech_task/services/shared_prefs_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() async {
  getIt.registerSingleton<APIService>(APIService());
  getIt.registerSingleton<SharedPrefsService>(SharedPrefsService());
}
