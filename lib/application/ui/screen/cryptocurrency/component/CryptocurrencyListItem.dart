import 'package:flutter/material.dart';

class CryptocurrencyListItem extends StatelessWidget {
  final String name;
  final String price;
  final bool isFavorite;

  final Function _onFavoriteToggled;

  const CryptocurrencyListItem({
    super.key,
    required this.name, 
    required this.price, 
    required this.isFavorite, 
    required onFavoriteToggled
  }) : _onFavoriteToggled = onFavoriteToggled;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.favorite_border),
        onPressed: () => _onFavoriteToggled(),
      ),
      title: Text(name),
      trailing: Text(price, style: textTheme.bodyLarge,),
    );
  }
}