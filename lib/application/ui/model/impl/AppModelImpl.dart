import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/model/_common/AppModel.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: AppModel)
class AppModelImpl extends AppModel {
  static const TAG = "AMI";

  int _chunkIndex = 1;
  int get chunkIndex => _chunkIndex;

  bool _isGettingChunk = false;
  bool get isGettingChunk => _isGettingChunk;

  int _lastChunkSize = 0;

  late Stream<List<CryptoPresentation>> _cryptoPresentationStream;
  late Stream<List<CryptoPresentation>> _favoriteCryptoPresentationStream;

  final BehaviorSubject<List<CryptoPresentation>> _cryptoPresentationStreamController = 
    BehaviorSubject();
  final BehaviorSubject<List<CryptoPresentation>> _favoriteCryptoPresentationStreamController = 
    BehaviorSubject();

  late StreamSubscription _cryptoPresentationStreamSubscription;
  late StreamSubscription _favoriteCryptoPresentationStreamSubscription;

  List<CryptoPresentation> _lastCryptoPresentationList = [];
  
  AppModelImpl(CryptoRepository cryptoRepository) {
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

    _favoriteCryptoPresentationStreamSubscription = cryptoRepository.favoriteDataCryptoStream
      .map((items) => items.map((item) => CryptoPresentation.fromDataCrypto(item)).toList())
      .listen((data) => _favoriteCryptoPresentationStreamController.add(data));

    _favoriteCryptoPresentationStream = _favoriteCryptoPresentationStreamController.stream.asBroadcastStream();
  }

  @override
  Stream<List<CryptoPresentation>> getAllCryptoPresentations() {
    cryptoRepository.loadCryptocurrencies(_chunkIndex * AppModel.CHUNK_SIZE);

    return _cryptoPresentationStream;
  }

  @override
  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations() {
    cryptoRepository.loadFavorites();

    return _favoriteCryptoPresentationStream;
  }

  @override
  void getNextChunk() {
    if (_isGettingChunk || _lastChunkSize % AppModel.CHUNK_SIZE != 0) return;

    _isGettingChunk = true;
    ++_chunkIndex;

    print("$TAG: getNextChunk(): _chunkIndex = $_chunkIndex;");

    cryptoRepository.loadCryptocurrencies(_chunkIndex * AppModel.CHUNK_SIZE);
  }
  
  @override
  void removeFromFavorites(CryptoPresentation crypto) {
    print("$TAG: removeFromFavorites(): entering");

    cryptoRepository.removeFromFavorites(crypto.token);
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