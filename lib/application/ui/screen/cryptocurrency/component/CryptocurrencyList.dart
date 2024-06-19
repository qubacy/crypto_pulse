import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyListItem.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/CryptocurrenciesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../_common/presentation/CryptoPresentation.dart';

class CryptocurrencyList extends StatefulWidget {
  final EdgeInsets padding;

  const CryptocurrencyList({
    this.padding = const EdgeInsets.all(0)
  });

  @override
  _CryptocurrencyListState createState() => _CryptocurrencyListState();
}

class _CryptocurrencyListState extends State<CryptocurrencyList> {
  static const int END_SCROLL_DELTA = 100;

  CryptocurrenciesModel? _model;
  List<CryptoPresentation> _lastItems = [];

  final ScrollController _scrollController = ScrollController();

  _CryptocurrencyListState() {
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
            _lastItems = listSnapshot.data ?? [];

            return  ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: widget.padding,
              itemBuilder: (context, index) {
                final item = _lastItems[index];

                return CryptocurrencyListItem(
                  cryptocurrency: item,
                  onFavoriteToggled: _onFavoriteToggled 
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: _lastItems.length,
              controller: _scrollController,
            );
          }
        );
      }
    );
  }

  void _onFavoriteToggled(CryptoPresentation crypto) {
    _model?.toggleFavoriteCrypto(crypto);
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
}