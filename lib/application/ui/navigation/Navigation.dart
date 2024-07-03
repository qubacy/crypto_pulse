import 'package:crypto_pulse/application/ui/screen/cryptocurrency/Cryptocurrencies.dart';
import 'package:crypto_pulse/application/ui/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage getRoutePageBuilder(
  GoRouterState state,
  Widget child 
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position:
          Tween(
            begin: const Offset(1, 0),
            end: Offset.zero
          ).animate(animation),
        child: child);
    },
  );
}

final routes = [
  GoRoute(
    path: Home.PATH,
    name: Home.NAME,
    pageBuilder: (context, state) {
      return getRoutePageBuilder(state, Home());
    },
  ),
  GoRoute(
    path: Cryptocurrencies.PATH,
    name: Cryptocurrencies.NAME,
    pageBuilder: (context, state) {
      return getRoutePageBuilder(state, const Cryptocurrencies());
    }
  )
];

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