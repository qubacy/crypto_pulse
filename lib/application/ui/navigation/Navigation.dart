import 'package:crypto_pulse/application/ui/screen/cryptocurrency/Cryptocurrencies.dart';
import 'package:crypto_pulse/application/ui/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage getRoutePageBuilder(
  String pagePath,
  GoRouterState state,
  Widget child 
) {
  // NOTE: it's not easy to provide page sliding animation including BOTH prev. and cur. ones;
  //       there's a way using Navigator instead of go_router to provide an exit animation OR to
  //       get the prev. destination here; so let's just keep it simple for now;

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
        child: child
      );
    },
  );
}

final routes = [
  GoRoute(
    path: Home.PATH,
    name: Home.NAME,
    pageBuilder: (context, state) {
      return getRoutePageBuilder(Home.PATH, state, Home());
    },
  ),
  GoRoute(
    path: Cryptocurrencies.PATH,
    name: Cryptocurrencies.NAME,
    pageBuilder: (context, state) {
      return getRoutePageBuilder(Cryptocurrencies.PATH, state, const Cryptocurrencies());
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