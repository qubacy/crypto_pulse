import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyList.dart';
import 'package:flutter/material.dart';
import '../_common/screen.dart';

class Cryptocurrencies extends StatelessWidget implements Screen {
  const Cryptocurrencies({super.key});

  @override
  List<Widget> getActions() {
    return <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    return CryptocurrencyList(
        
      );
  }
}