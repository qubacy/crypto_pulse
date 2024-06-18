import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyListItem.dart';
import 'package:flutter/material.dart';
import '../../_common/presentation/Cryptocurrency.dart';

class CryptocurrencyList extends StatefulWidget {
  final EdgeInsets padding;

  const CryptocurrencyList({
    this.padding = const EdgeInsets.all(0)
  });

  @override
  _CryptocurrencyListState createState() => _CryptocurrencyListState();
}

class _CryptocurrencyListState extends State<CryptocurrencyList> {
  // todo: to delete:
  List<Cryptocurrency> _items = List.generate(10, (index) {
    return Cryptocurrency(name: "Crypto #$index", price: "${index * 1000}");
  });

  _CryptocurrencyListState();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: widget.padding,
      itemBuilder: (context, index) {
        // todo: implement:
        final item = _items[index];

        return CryptocurrencyListItem(
          name: item.name,
          price: item.price,
          onAddedToFavorite: _onAddedToFavorite 
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _items.length,
    );
  }

  void _onAddedToFavorite(String name) {
    // todo: implement..


  }
}