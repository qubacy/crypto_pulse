import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyListItem.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../_common/presentation/CryptoPresentation.dart';

class CryptocurrencyList extends StatelessWidget implements CryptocurrencyListItemCallback {
  static const int END_SCROLL_DELTA = 5;

  CryptocurrenciesModel? _model;

  final ScrollController _scrollController = ScrollController();
  final EdgeInsets padding;

  CryptocurrencyList({super.key, this.padding = const EdgeInsets.all(0)}) {
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptocurrenciesModel>(
      builder: (context, model, child) {
        _model = model; 

        return StreamBuilder(
          stream: model.getAllCryptoPresentations(),
          builder: (context, listSnapshot) {
            final lastItems = listSnapshot.data ?? [];

            return  ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: padding,
              itemBuilder: (context, index) {
                final item = lastItems[index];

                return CryptocurrencyListItem(
                  cryptoPresentation: item,
                  callback: this, 
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: lastItems.length,
              controller: _scrollController,
            );
          }
        );
      }
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final curScroll = _scrollController.position.pixels;

    if (maxScroll - curScroll <= END_SCROLL_DELTA)
      _onEndReached();
  }

  void _onEndReached() {
    _model?.getNextChunk();
  }
  
  @override
  void onFavoriteToggled(CryptoPresentation cryptoPresentation) {
    _model?.toggleFavoriteCrypto(cryptoPresentation);
  }
}