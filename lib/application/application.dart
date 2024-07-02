import 'package:crypto_pulse/application/ui/screen/cryptocurrency/Cryptocurrencies.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:crypto_pulse/application/ui/screen/home/home.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:crypto_pulse/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final routes = [
  GoRoute(
    path: Home.PATH,
    name: Home.NAME,
    builder: (context, state) => Home(),
  ),
  GoRoute(
    path: Cryptocurrencies.PATH,
    name: Cryptocurrencies.NAME,
    builder: (context, state) => const Cryptocurrencies()
  )
];

final _router = GoRouter(
  routes: routes
  // routes: [
  //   ShellRoute(
  //     builder: (context, state, child) {
  //       final bottomNavigationBar = _buildNavigationBar(context, state.fullPath);

  //       return Scaffold(
  //         //appBar: _buildAppBar(bottomNavigationBar.selectedIndex, child),
  //         bottomNavigationBar: bottomNavigationBar,
  //         body: child
  //       );
  //     },
  //     routes: _routes
  //   )
  // ]
);

final navigationBarDestinations = <NavigationDestination>[
  NavigationDestination(
    icon: const Icon(Icons.home),
    label: routes[0].name!
  ),
  NavigationDestination(
    icon: const SvgIcon(icon: SvgIconData('assets/images/crypto.svg')),
    label: routes[1].name!
  ),
];

// NavigationBar _buildNavigationBar(BuildContext context, String? routePath) {
//   return NavigationBar(
//     selectedIndex: _getNavigationBarDestinationIndexByRoutePath(routePath),
//     destinations: navigationBarDestinations,
//     onDestinationSelected: (index) {
//       context.go(_routes[index].path);
//     },
//   );
// }

// int _getNavigationBarDestinationIndexByRoutePath(String? path) {
//   print("_getNavigationBarDestinationIndexByRoutePath(): name = $path");

//   return switch (path) {
//     Home.PATH => 0,
//     Cryptocurrencies.PATH => 1,
//     _ => throw Exception()
//   };
// }

class Application extends StatelessWidget {
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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x006974)),
          useMaterial3: true,
        ),
      )
    );
  }
}