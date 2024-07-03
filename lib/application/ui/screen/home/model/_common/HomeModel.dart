import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:flutter/widgets.dart';

import '../../../../_common/presentation/CryptoPresentation.dart';

abstract class HomeModel extends ChangeNotifier {
  late final CryptoRepository cryptoRepository;
  bool get isLoading;

  Stream<List<CryptoPresentation>> get favoriteCryptoPresentationStream;

  void clear();
  void getFavoriteCryptoPresentations();
  void removeFromFavorites(CryptoPresentation crypto);
}