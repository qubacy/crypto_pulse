import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:flutter/material.dart';

class CryptocurrencyListItem extends StatelessWidget {
  final CryptoPresentation cryptocurrency;

  final Function _onFavoriteToggled;

  const CryptocurrencyListItem({
    super.key,
    required this.cryptocurrency,
    required onFavoriteToggled
  }) : _onFavoriteToggled = onFavoriteToggled;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.favorite_border),
        onPressed: () => _onFavoriteToggled(cryptocurrency.token),
      ),
      title: Text(cryptocurrency.name),
      trailing: Text(cryptocurrency.price, style: textTheme.bodyLarge,),
    );
  }
}