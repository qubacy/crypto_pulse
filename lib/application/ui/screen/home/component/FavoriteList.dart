import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  final GlobalKey? _hintTextKey;

  const FavoriteList({super.key, GlobalKey? hintTextKey}) : _hintTextKey = hintTextKey;

  @override
  State<FavoriteList> createState() => _FavoriteListState(hintTextKey: _hintTextKey);
}

class _FavoriteListState extends State<FavoriteList> {
  final GlobalKey? _hintTextKey;

  _FavoriteListState({GlobalKey? hintTextKey}) : 
    _hintTextKey =  hintTextKey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        // todo: implement:

        return index < 3 ? Text("item $index") : null;
      },
    );
  }
}