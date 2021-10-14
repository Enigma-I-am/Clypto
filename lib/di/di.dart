import 'package:clypto/data/local/cache.dart';
import 'package:clypto/data/remote/clypto_repo.dart';
import 'package:clypto/data/remote/clypto_service.dart';
import 'package:clypto/handlers/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //  pref
  getIt.registerSingleton(sharedPreferences);

  // Cache
  getIt.registerLazySingleton<LocalCache>(() => LocalCacheImpl(sharedPreferences: getIt()));

  // Navigation
  getIt.registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());

  getIt.registerLazySingleton<ClyptoRepo>(() => ClyptoRepoImpl());
  getIt.registerLazySingleton<ClyptoService>(() => ClyptoServiceImpl(repo: getIt()));
}
