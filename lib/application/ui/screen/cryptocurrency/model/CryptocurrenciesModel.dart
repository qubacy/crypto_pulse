import 'package:flutter/widgets.dart';

import '../../../_common/presentation/CryptoPresentation.dart';

mixin CryptocurrenciesModel implements ChangeNotifier {
  Stream<List<CryptoPresentation>> getAllCryptoPresentations();
  void toggleFavoriteCrypto(CryptoPresentation crypto);
  void getNextChunk();
}