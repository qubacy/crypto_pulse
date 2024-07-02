import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:flutter/widgets.dart';

abstract class AppModel extends ChangeNotifier {
  static const int CHUNK_SIZE = 20;

  late final CryptoRepository cryptoRepository;
}