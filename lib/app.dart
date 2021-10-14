import 'package:clypto/handlers/navigation_service.dart';
import 'package:clypto/presentation/details/cubit/detail_cubit.dart';
import 'package:clypto/presentation/home/view/home.dart';
import 'package:clypto/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'di/di.dart';

class BlocLocator extends StatelessWidget {
  const BlocLocator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DetailCubit>(
        create: (context) => DetailCubit()..getExchanges()..getExchengeBalance(),
      ),
    ], child: App());
  }
}

class App extends StatelessWidget {
  final _navService = getIt<NavigationHandler>();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic App',
      themeMode: ThemeMode.light,
      navigatorKey: _navService.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFF3B405E),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: const HomePage(),
    );
  }
}
