import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:flutter/widgets.dart';

import '../../../../_common/presentation/CryptoPresentation.dart';

abstract class HomeModel extends ChangeNotifier {
  late final CryptoRepository cryptoRepository;

  Stream<List<CryptoPresentation>> getFavoriteCryptoPresentations();
  void removeFromFavorites(CryptoPresentation crypto);
}