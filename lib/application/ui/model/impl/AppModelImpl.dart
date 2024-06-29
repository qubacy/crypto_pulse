import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/model/_common/AppModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppModel)
class AppModelImpl extends AppModel {
  int _chunkIndex = 1;
  int get chunkIndex => _chunkIndex;

  bool _isGettingChunk = false;
  bool get isGettingChunk => _isGettingChunk;

  int _lastChunkSize = 0;

  late Stream<List<CryptoPresentation>> _cryptoPresentationStream;
  
  AppModelImpl(CryptoRepository cryptoRepository) {
    super.cryptoRepository = cryptoRepository;

    _cryptoPresentationStream = cryptoRepository.dataCryptoStream
      .map((items) {
        if (_isGettingChunk) _isGettingChunk = false;

        _lastChunkSize = items.length;

        return items.map((item) => CryptoPresentation.fromDataCrypto(item)).toList();
      });
  }

  @override
  Stream<List<CryptoPresentation>> getAllCryptoPresentations() {
    cryptoRepository.loadCryptocurrencies(_chunkIndex * AppModel.CHUNK_SIZE);

    return _cryptoPresentationStream;
  }

  @override
  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations() {
    return _cryptoPresentationStream.map((list) {
      print('getFavoriteCryptoPresentations(): list = ${list.map((elem) => elem.name)};');

      return list.where((item) => item.isFavorite).toList();
    });
  }

  @override
  void getNextChunk() {
    if (_isGettingChunk || _lastChunkSize % AppModel.CHUNK_SIZE != 0) return;

    _isGettingChunk = true;
    ++_chunkIndex;

    print("getNextChunk(): _chunkIndex = $_chunkIndex;");

    cryptoRepository.loadCryptocurrencies(_chunkIndex * AppModel.CHUNK_SIZE);
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