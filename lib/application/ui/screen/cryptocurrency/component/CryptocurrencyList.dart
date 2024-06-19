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
  CryptocurrenciesModel? _model;
  List<CryptoPresentation> _lastItems = [];

  _CryptocurrencyListState();

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
                // todo: implement:
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
            );
          }
        );
      }
    );
  }

  void _onFavoriteToggled(CryptoPresentation crypto) {
    _model?.toggleFavoriteCrypto(crypto);
  }
}