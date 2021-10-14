import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bloc/bloc.dart';
import 'package:clypto/utils/clypto_logger.dart';
import 'package:flutter/widgets.dart';

import 'di/di.dart';

class AppBlocObserver extends BlocObserver {
  final logger = MyLogger.logger;
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // logger.d('AppBlocObserver: onChange(${bloc.runtimeType}, $change)');`
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.d('AppBlocObserver: onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = MyLogger.logger;
  await dotenv.load();

  await init();
  Bloc.observer = AppBlocObserver();

  FlutterError.onError = (details) {
    logger.d(
      "Error! here: ${details.exceptionAsString()}",
      details.exceptionAsString(),
      details.stack,
    );
  };

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => logger.d("Error!! here:", error.toString(), stackTrace),
  );
}
