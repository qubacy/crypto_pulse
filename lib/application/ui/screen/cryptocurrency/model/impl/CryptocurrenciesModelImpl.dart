import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: CryptocurrenciesModel)
class CryptocurrenciesModelImpl extends CryptocurrenciesModel {
  static const TAG = 'CMI';

  int _chunkIndex = 1;
  int get chunkIndex => _chunkIndex;

  bool _isGettingChunk = false;
  bool get isGettingChunk => _isGettingChunk;

  int _lastChunkSize = 0;

  late Stream<List<CryptoPresentation>> _cryptoPresentationStream;

  final BehaviorSubject<List<CryptoPresentation>> _cryptoPresentationStreamController = 
    BehaviorSubject();

  late StreamSubscription _cryptoPresentationStreamSubscription;

  List<CryptoPresentation> _lastCryptoPresentationList = [];

  CryptocurrenciesModelImpl(CryptoRepository cryptoRepository) {
    super.cryptoRepository = cryptoRepository;

    _cryptoPresentationStreamSubscription = cryptoRepository.dataCryptoStream
      .map((items) {
        if (_isGettingChunk) _isGettingChunk = false;

        _lastChunkSize = items.length;
        _lastCryptoPresentationList = items.map((item) => CryptoPresentation.fromDataCrypto(item)).toList();

        return _lastCryptoPresentationList;
      })
      .listen((data) => _cryptoPresentationStreamController.add(data));

    _cryptoPresentationStream = _cryptoPresentationStreamController.stream.asBroadcastStream();
  }

  @override
  Stream<List<CryptoPresentation>> getAllCryptoPresentations() {
    cryptoRepository.loadCryptocurrencies(_chunkIndex * CryptocurrenciesModel.CHUNK_SIZE);

    return _cryptoPresentationStream;
  }

  @override
  void getNextChunk() {
    if (_isGettingChunk || _lastChunkSize % CryptocurrenciesModel.CHUNK_SIZE != 0) return;

    _isGettingChunk = true;
    ++_chunkIndex;

    print("$TAG: getNextChunk(): _chunkIndex = $_chunkIndex;");

    cryptoRepository.loadCryptocurrencies(_chunkIndex * CryptocurrenciesModel.CHUNK_SIZE);
  }

  @override
  void toggleFavoriteCrypto(CryptoPresentation crypto) {
    print("$TAG: toggleFavoriteCrypto(): entering");

    if (crypto.isFavorite) cryptoRepository.removeFromFavorites(crypto.token);
    else cryptoRepository.addToFavorites(crypto.token);

    _applyFavoriteChange(crypto);
  }

  void _applyFavoriteChange(CryptoPresentation crypto) {
    final lastCryptoPresentationList = _lastCryptoPresentationList;

    for (final indexedLastCryptoPresentation in lastCryptoPresentationList.indexed) {
      if (indexedLastCryptoPresentation.$2.token != crypto.token) continue;

      lastCryptoPresentationList[indexedLastCryptoPresentation.$1] = 
        indexedLastCryptoPresentation.$2.copyWith(isFavorite: !crypto.isFavorite);

      break;
    }

    _cryptoPresentationStreamController.add(lastCryptoPresentationList);
  }
}