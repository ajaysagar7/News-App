import 'package:get_it/get_it.dart';
import 'package:news_app/src/services/api_services.dart';

GetIt locator = GetIt.instance;

setUpLocator() {
  locator.registerLazySingleton(() => ApiServices());
}
