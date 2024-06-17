import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  final GlobalKey? _hintTextKey;

  final EdgeInsets margin;

  const FavoriteList({
    super.key, GlobalKey? hintTextKey, 
    this.margin = const EdgeInsets.all(0)
  }) : _hintTextKey = hintTextKey;

  @override
  State<FavoriteList> createState() => _FavoriteListState(hintTextKey: _hintTextKey);
}

class _FavoriteListState extends State<FavoriteList> {
  static const VISIBLE_ITEM_COUNT = 20;

  final GlobalKey? _hintTextKey;

  _FavoriteListState({
    GlobalKey? hintTextKey 
  }) : 
    _hintTextKey =  hintTextKey;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: widget.margin,
      itemBuilder: (context, index) {
        // todo: implement:

        return index < 3 ? FavoriteListItem(name: 'Crypto', price: '\$54900', ) : null;
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: VISIBLE_ITEM_COUNT,
    );
  }
}