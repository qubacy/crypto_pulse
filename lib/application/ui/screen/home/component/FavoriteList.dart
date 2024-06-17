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
  final GlobalKey? _hintTextKey;

  _FavoriteListState({
    GlobalKey? hintTextKey 
  }) : 
    _hintTextKey =  hintTextKey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: widget.margin,
      itemBuilder: (context, index) {
        // todo: implement:

        return index < 3 ? Text("item $index") : null;
      },
    );
  }
}