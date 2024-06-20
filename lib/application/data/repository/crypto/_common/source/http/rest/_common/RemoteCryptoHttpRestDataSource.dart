import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';

abstract class RemoteCryptoHttpRestDataSource {
  late final RemoteCryptoHttpRestDataSourceApi api;

  Future<List<RemoteHttpRestCrypto>> getCryptocurrencies(int count);
}