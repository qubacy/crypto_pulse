import 'package:crypto_pulse/application/ui/screen/cryptocurrency/Cryptocurrencies.dart';
import 'package:crypto_pulse/application/ui/screen/home/Home.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:flutter/material.dart';
import './screen/_common/screen.dart';

class Host extends StatefulWidget {
  const Host({super.key});

  @override
  _HostState createState() => _HostState();
}

class _HostState extends State<Host> {
  final List<NavigationDestination> _destinations = const <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home),
      label: "Home"
    ),
    NavigationDestination(
      icon: SvgIcon(icon: SvgIconData('assets/images/crypto.svg')),
      label: "Cryptocurrencies"
    ),
  ];

  int curNavigationDistinationIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = _getScreen(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_destinations[curNavigationDistinationIndex].label),
        actions: _getAppBarActionsByScreen(currentScreen as Screen),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: curNavigationDistinationIndex,
        onDestinationSelected: (value) {
          setState(() {
            curNavigationDistinationIndex = value;
          });
        },
        destinations: _destinations,
      ),
      body: currentScreen
    );
  }

  Widget _getScreen(BuildContext context) {
    return switch(curNavigationDistinationIndex) {
      0 => _getHome(context),
      1 => _getCryptocurrencies(context),
      _ => throw UnimplementedError()
    };
  }

  Widget _getHome(BuildContext context) {
    return Home();
  }

  Widget _getCryptocurrencies(BuildContext context) {
    return Cryptocurrencies();
  }

  List<Widget> _getAppBarActionsByScreen(Screen screen) {
    return screen.getActions();
  }
}