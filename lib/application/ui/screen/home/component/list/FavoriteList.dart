import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey? _hintTextKey;
  
  HomeModel? _model;
  List<CryptoPresentation> _lastItems = [];

  _FavoriteListState({
    GlobalKey? hintTextKey 
  }) : 
    _hintTextKey =  hintTextKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        _model = model; 

        return StreamBuilder(
          stream: model.getFavoriteCryptoPresentations(),
          builder: (context, listSnapshot) {
            _lastItems = listSnapshot.data ?? [];

            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: widget.padding,
              itemBuilder: (context, index) {
                final item = _lastItems[index];

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
              itemCount: _lastItems.length,
            );
          }
        );
      }
    );
  }

  void _handleCryptoRemoval(int index) {
    final cryptocurrencyToRemove = _lastItems[index];

    setState(() {
      _lastItems.removeAt(index);
    });

    _model?.removeFromFavorites(cryptocurrencyToRemove);
  }
}