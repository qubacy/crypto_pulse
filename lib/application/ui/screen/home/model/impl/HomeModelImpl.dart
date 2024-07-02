import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: HomeModel)
class HomeModelImpl extends HomeModel {
  static const TAG = 'HMI';

  late Stream<List<CryptoPresentation>> _favoriteCryptoPresentationStream;

  final BehaviorSubject<List<CryptoPresentation>> _favoriteCryptoPresentationStreamController = 
    BehaviorSubject();

  late StreamSubscription _favoriteCryptoPresentationStreamSubscription;

  HomeModelImpl(CryptoRepository cryptoRepository) {
    super.cryptoRepository = cryptoRepository;

    _favoriteCryptoPresentationStreamSubscription = cryptoRepository.favoriteDataCryptoStream
      .map((items) => items.map((item) => CryptoPresentation.fromDataCrypto(item)).toList())
      .listen((data) => _favoriteCryptoPresentationStreamController.add(data));

    _favoriteCryptoPresentationStream = _favoriteCryptoPresentationStreamController.stream.asBroadcastStream();
  }

  @override
  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations() {
    cryptoRepository.loadFavorites();

    return _favoriteCryptoPresentationStream;
  }

  @override
  void removeFromFavorites(CryptoPresentation crypto) {
    print("$TAG: removeFromFavorites(): entering");

    cryptoRepository.removeFromFavorites(crypto.token);
  }
}