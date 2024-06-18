import 'dart:async';
import 'dart:collection';

import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:flutter/widgets.dart';

class HostModel extends ChangeNotifier {
  static const int CHUNK_SIZE = 20;

  int _chunkCount = 1;
  late Stream<List<CryptoPresentation>> _cryptoPresentationStream = Stream
    // todo: to delete (provide the real deal):
    .value(List.generate(10, (index) {
      return CryptoPresentation(token: "$index", name: "Crypto #$index", price: "${index * 1000}", isFavorite: true);
    }));

  HostModel() {
    // todo: subscribing to Domain layer Crypto stream..


  }

  Stream<List<CryptoPresentation>> getAllCryptoPresentations() {
    return _cryptoPresentationStream;
  }

  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations() {
    return _cryptoPresentationStream.asyncMap((list) {
      return Future.value(list.where((item) => item.isFavorite).toList());
    });
  }

  void getNextChunk() {
    ++_chunkCount;

    // todo: calling Domain layer method..


  }
}