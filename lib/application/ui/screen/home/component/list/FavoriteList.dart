import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatelessWidget {
  final GlobalKey? _hintTextKey;
  HomeModel? _model;

  final EdgeInsets padding;

  FavoriteList({
    super.key, GlobalKey? hintTextKey, 
    this.padding = const EdgeInsets.all(0)
  }) : _hintTextKey = hintTextKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        _model = model; 

        return StreamBuilder(
          stream: model.getFavoriteCryptoPresentations(),
          builder: (context, listSnapshot) {
            final lastItems = listSnapshot.data ?? [];

            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: padding,
              itemBuilder: (context, index) {
                final item = lastItems[index];

                return Dismissible(
                  key: ValueKey<String>(item.name),
                  onDismissed: (direction) {
                    _handleCryptoRemoval(item);
                  },
                  dismissThresholds: const { DismissDirection.startToEnd: 0.5 },
                  direction: DismissDirection.startToEnd,
                  background: Container(color: Colors.red,),
                  child: FavoriteListItem(name: item.name, price: item.price,)
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: lastItems.length,
            );
          }
        );
      }
    );
  }

  void _handleCryptoRemoval(CryptoPresentation cryptoPresentation) {
    _model?.removeFromFavorites(cryptoPresentation);
  }
}