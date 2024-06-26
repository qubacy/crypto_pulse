import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:flutter/material.dart';

class CryptocurrencyListItem extends StatelessWidget {
  static Key getFavoriteIconKey(String token) {
    return Key("favorite_icon_button_$token");
  }

  final CryptoPresentation cryptoPresentation;

  final Function _onFavoriteToggled;

  const CryptocurrencyListItem({
    super.key,
    required this.cryptoPresentation,
    required onFavoriteToggled
  }) : _onFavoriteToggled = onFavoriteToggled;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: IconButton(
        key: getFavoriteIconKey(cryptoPresentation.token),
        icon: cryptoPresentation.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
        onPressed: () => _onFavoriteToggled(cryptoPresentation),
      ),
      title: Text(cryptoPresentation.name),
      trailing: Text(cryptoPresentation.price, style: textTheme.bodyLarge,),
    );
  }
}