import 'package:flutter/material.dart';

class FavoriteListItem extends StatelessWidget {
  final String name;
  final String price;

  const FavoriteListItem({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(name),
      trailing: Text(price, style: textTheme.bodyLarge,),
    );
  }
}