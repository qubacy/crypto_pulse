import 'package:crypto_pulse/application/ui/navigation/Navigation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:crypto_pulse/di/di.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _router = GoRouter(
  routes: routes
);

class Application extends StatelessWidget {
  static const Test = '';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeModel>(create: (context) => getIt.get<HomeModel>()),
        ChangeNotifierProvider<CryptocurrenciesModel>(create: (context) => getIt.get<CryptocurrenciesModel>())
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Crypto Pulse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xEEB82F)),
          useMaterial3: true,
        ),
      )
    );
  }
}