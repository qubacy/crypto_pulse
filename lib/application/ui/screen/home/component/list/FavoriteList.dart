import 'package:crypto_pulse/application/ui/screen/_common/presentation/Cryptocurrency.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  final GlobalKey? _hintTextKey;

  final EdgeInsets padding;

  const FavoriteList({
    super.key, GlobalKey? hintTextKey, 
    this.padding = const EdgeInsets.all(0)
  }) : _hintTextKey = hintTextKey;

  @override
  State<FavoriteList> createState() => _FavoriteListState(hintTextKey: _hintTextKey);
}

class _FavoriteListState extends State<FavoriteList> {
  static const VISIBLE_ITEM_COUNT = 20;

  final GlobalKey? _hintTextKey;

  // todo: to delete:
  List<Cryptocurrency> _items = List.generate(10, (index) {
    return Cryptocurrency(name: "Crypto #$index", price: "${index * 1000}");
  });

  _FavoriteListState({
    GlobalKey? hintTextKey 
  }) : 
    _hintTextKey =  hintTextKey;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: widget.padding,
      itemBuilder: (context, index) {
        // todo: implement:
        if (index >= _items.length) return null;

        final item = _items[index];

        return Dismissible(
          key: ValueKey<String>(item.name),
          onDismissed: (direction) {
            _handleCryptoRemoval(index);
          },
          dismissThresholds: const { DismissDirection.startToEnd: 0.5 },
          direction: DismissDirection.startToEnd,
          background: Container(color: Colors.red,),
          child: FavoriteListItem(name: item.name, price: item.price,)
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _items.length,
    );
  }


  void _handleCryptoRemoval(int index) {
    final cryptocurrencyToRemove = _items[index];

    setState(() {
      _items.removeAt(index);
    });

    // todo: implement actual removing here..


  }
}