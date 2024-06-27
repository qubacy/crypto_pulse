import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/model/_common/AppModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppModel)
class AppModelImpl extends AppModel {
  int _chunkCount = 0;
  int get chunkCount => _chunkCount;

  late Stream<List<CryptoPresentation>> _cryptoPresentationStream;
  
  AppModelImpl(CryptoRepository cryptoRepository) {
    super.cryptoRepository = cryptoRepository;

    _cryptoPresentationStream = cryptoRepository.dataCryptoStream
      .map((items) => items.map((item) => CryptoPresentation.fromDataCrypto(item)).toList());
  }

  @override
  Stream<List<CryptoPresentation>> getAllCryptoPresentations() {
    return _cryptoPresentationStream;
  }

  @override
  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations() {
    return _cryptoPresentationStream.asyncMap((list) {
      final favoriteList = list.where((item) => item.isFavorite).toList();

      return Future.value(favoriteList);
    });
  }

  @override
  void getNextChunk() {
    ++_chunkCount;

    cryptoRepository.loadCryptocurrencies(_chunkCount * AppModel.CHUNK_SIZE);
  }
  
  @override
  void removeFromFavorites(CryptoPresentation crypto) {
    cryptoRepository.removeFromFavorites(crypto.token);
  }
  
  @override
  void toggleFavoriteCrypto(CryptoPresentation crypto) {
    if (crypto.isFavorite) cryptoRepository.removeFromFavorites(crypto.token);
    else cryptoRepository.addToFavorites(crypto.token);
  }
}