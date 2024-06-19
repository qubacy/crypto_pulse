import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/HttpCryptoRestDataSourceApi.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/HttpRestCrypto.dart';

abstract class HttpCryptoRestDataSource {
  late final HttpCryptoRestDataSourceApi api;

  Future<List<HttpRestCrypto>> getCryptocurrencies(int count);
}