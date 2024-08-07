import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
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

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) => model.getFavoriteCryptoPresentations());

        return StreamBuilder(
          stream: model.favoriteCryptoPresentationStream,
          builder: (context, listSnapshot) {
            final lastItems = listSnapshot.data ?? [];

            print('FavoriteList: lastItems.length = ${lastItems.length}');

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