import 'dart:async';
import 'dart:math';

import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/CryptocurrenciesModel.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/HomeModel.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class AppModel extends ChangeNotifier with CryptocurrenciesModel, HomeModel {
  static const int CHUNK_SIZE = 20;

  int _chunkCount = 1;
  final BehaviorSubject<List<CryptoPresentation>> _cryptoStreamController = BehaviorSubject();

  // todo: to delete (provide the real deal):
  final List<CryptoPresentation> _cryptoPresentations = List.generate(CHUNK_SIZE, (index) {
    return CryptoPresentation(token: "$index", name: "Crypto #$index", price: "${index * 1000}", capitalization: 1, isFavorite: Random().nextBool());
  });
  late Stream<List<CryptoPresentation>> _cryptoPresentationStream;
  
  AppModel() {
    // todo: subscribing to Domain layer Crypto stream..

    _cryptoPresentationStream = Stream.value(_cryptoPresentations);

    _cryptoPresentationStream.listen((list) {
      _cryptoStreamController.add(list);
    });

    print(this.hashCode);
  }

  @override
  Stream<List<CryptoPresentation>> getAllCryptoPresentations() {
    return _cryptoStreamController.stream;
  }

  @override
  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations() {
    return _cryptoStreamController.stream.asyncMap((list) {
      final favoriteList = list.where((item) => item.isFavorite).toList();

      return Future.value(favoriteList);
    });
  }

  @override
  void getNextChunk() {
    ++_chunkCount;

    // todo: calling Domain layer method..

    // todo: to delete (temporal solution):
    _cryptoPresentations.addAll(
      List.generate(CHUNK_SIZE, (index) {
        final finalIndex = index + (CHUNK_SIZE * (_chunkCount - 1));

        return CryptoPresentation(
          token: "$finalIndex", name: "Crypto #$finalIndex", price: "${finalIndex * 1000}", capitalization: finalIndex * 1000000, isFavorite: Random().nextBool()
        );
      })
    );

    _cryptoStreamController.add(_cryptoPresentations);
  }
  
  @override
  void removeFromFavorites(CryptoPresentation crypto) {
    // todo: to delete (temporal solution):

    toggleFavoriteCrypto(crypto);
  }
  
  @override
  void toggleFavoriteCrypto(CryptoPresentation crypto) {
    // todo: to delete (temporal solution):

    print("toggleFavoriteCrypto(): crypto.name = ${crypto.name};");

    for (int index = 0; index < _cryptoPresentations.length; ++index) {
      final cryptoPresentation = _cryptoPresentations[index];

      print("toggleFavoriteCrypto() for: cryptoPresentation.name = ${cryptoPresentation.name};");

      if (cryptoPresentation != crypto) continue;

      _cryptoPresentations[index] = cryptoPresentation.copyWith(isFavorite: !cryptoPresentation.isFavorite);

      break;
    }

    _cryptoStreamController.add(_cryptoPresentations);
  }
}