import 'package:crypto_pulse/application/ui/screen/cryptocurrency/Cryptocurrencies.dart';
import 'package:crypto_pulse/application/ui/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:go_router/go_router.dart';

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