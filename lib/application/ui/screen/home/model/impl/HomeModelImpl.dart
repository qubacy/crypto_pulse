import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: HomeModel)
class HomeModelImpl extends HomeModel {
  static const TAG = 'HMI';

  bool _isDisposed = false;

  bool _isLoading = false;
  @override
  bool get isLoading => _isLoading;

  bool _isFavoriteCryptoRequested = false;

  late Stream<List<CryptoPresentation>> _favoriteCryptoPresentationStream;
  @override
  Stream<List<CryptoPresentation>> get favoriteCryptoPresentationStream => _favoriteCryptoPresentationStream;

  final BehaviorSubject<List<CryptoPresentation>> _favoriteCryptoPresentationStreamController = 
    BehaviorSubject();

  late StreamSubscription _favoriteCryptoPresentationStreamSubscription;

  HomeModelImpl(CryptoRepository cryptoRepository) {
    super.cryptoRepository = cryptoRepository;

    _favoriteCryptoPresentationStreamSubscription = cryptoRepository.favoriteDataCryptoStream
      .map((items) { 
        if (_isLoading) _changeLoadingState(false);

        return items.map((item) => CryptoPresentation.fromDataCrypto(item)).toList();
      })
      .listen((data) => _favoriteCryptoPresentationStreamController.add(data));

    _favoriteCryptoPresentationStream = _favoriteCryptoPresentationStreamController.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    _isDisposed = true;

    _isLoading = false;
    _isFavoriteCryptoRequested = false;
    
    super.dispose();
  }

  @override
  void getFavoriteCryptoPresentations() {
    if (_isFavoriteCryptoRequested) return;

    _isFavoriteCryptoRequested = true;

    _changeLoadingState(true);
    cryptoRepository.loadFavorites();
  }

  @override
  void removeFromFavorites(CryptoPresentation crypto) {
    print("$TAG: removeFromFavorites(): entering");

    cryptoRepository.removeFromFavorites(crypto.token);
  }

  void _changeLoadingState(bool isLoading) {
    _isLoading = isLoading;

    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    
    super.notifyListeners();
  }
}