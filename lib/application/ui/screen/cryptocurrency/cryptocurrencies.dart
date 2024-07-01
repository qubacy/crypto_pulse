import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyList.dart';
import 'package:flutter/material.dart';
import '../_common/screen.dart';

class Cryptocurrencies extends StatelessWidget implements Screen {
  static const NAME = "Cryptocurrencies";
  static const PATH = "/cryptocurrencies";

  const Cryptocurrencies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: const Text(NAME),
          actions: [],
        ),
        Flexible(child: CryptocurrencyList())
      ]
    );
  }
}