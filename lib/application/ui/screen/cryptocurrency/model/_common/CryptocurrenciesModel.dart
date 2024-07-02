import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:flutter/widgets.dart';

import '../../../../_common/presentation/CryptoPresentation.dart';

abstract class CryptocurrenciesModel extends ChangeNotifier {
  static const int CHUNK_SIZE = 20;

  late final CryptoRepository cryptoRepository;
  bool get isLoading;

  Stream<List<CryptoPresentation>> get cryptoPresentationStream;

  void getAllCryptoPresentations();
  void toggleFavoriteCrypto(CryptoPresentation crypto);
  void getNextChunk();
}