import 'package:crypto_pulse/application/application.dart';
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
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final currentName = navigatorContext != null ? ModalRoute.of(navigatorContext!)?.settings.name ?? pagePath : pagePath;
      
      print('getRoutePageBuilder(): pagePath = $pagePath; currentName = $currentName;');
      
      if (pagePath == currentName)
        animation.addListener(() => print('pageKey: $pagePath; animation.value = ${animation.value};'));
      else
        secondaryAnimation.addListener(() => print('pageKey: $pagePath; secondaryAnimation.value = ${secondaryAnimation.value};'));

      return SlideTransition(
        position:
          Tween(
            begin: const Offset(1, 0),
            end: Offset.zero
          ).animate(pagePath == currentName ? animation : secondaryAnimation),
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