import 'package:crypto_pulse/application/ui/navigation/Navigation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyList.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../_common/screen.dart';

class Cryptocurrencies extends StatefulWidget implements Screen {
  static const NAME = "Cryptocurrencies";
  static const PATH = "/cryptocurrencies";

  const Cryptocurrencies({super.key});

  @override
  State<Cryptocurrencies> createState() => _CryptocurrenciesState();
}

class _CryptocurrenciesState extends State<Cryptocurrencies> {
  CryptocurrenciesModel? _model;

  @override
  void dispose() {
    _model?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptocurrenciesModel>(
      builder: (context, model, child) {
        _model = model;

        return Scaffold(
          appBar: AppBar(
            title: const Text(Cryptocurrencies.NAME),
            actions: [],
            bottom: model.isLoading ? const PreferredSize(
              preferredSize: Size.fromHeight(6),
              child: LinearProgressIndicator()
            ) : null,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: 1,
            destinations: navigationBarDestinations,
            onDestinationSelected: (index) {
              context.go(routes[index].path);
            },
          ),
          body: CryptocurrencyList()
        );
      }
    );
  }
}