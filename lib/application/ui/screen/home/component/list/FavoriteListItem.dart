import 'package:flutter/material.dart';

class FavoriteListItem extends StatefulWidget {
  final String name;
  final String price;

  FavoriteListItem({super.key, required this.name, required this.price});

  @override
  State<FavoriteListItem> createState() => _FavoriteListItemState();
}

class _FavoriteListItemState extends State<FavoriteListItem> with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Transform.translate(
      offset: _offset,
      child: ListTile(
        title: Text(widget.name),
        trailing: Text(widget.price, style: textTheme.bodyLarge,),
      )
    );
  }
}