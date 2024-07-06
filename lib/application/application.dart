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

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _selectedDestinationIndex = 0;

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
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) {
                  return Scaffold(
                    bottomNavigationBar: NavigationBar(
                      selectedIndex: _selectedDestinationIndex,
                      destinations: navigationBarDestinations,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedDestinationIndex = index;
                        });

                        _router.go(routes[index].path);
                      },
                    ),
                    body: child,
                  );
                },
              ),
            ],
          );
        },
      )
    );
  }
}