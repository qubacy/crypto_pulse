import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:flutter/widgets.dart';

import '../../screen/cryptocurrency/model/CryptocurrenciesModel.dart';
import '../../screen/home/model/HomeModel.dart';

abstract class AppModel extends ChangeNotifier with CryptocurrenciesModel, HomeModel {
  static const int CHUNK_SIZE = 20;

  late final CryptoRepository cryptoRepository;
}