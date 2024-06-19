import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/HttpCryptoRestDataSourceApi.dart';

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/HttpRestCrypto.dart';

import '../_common/HttpCryptoRestDataSource.dart';

class HttpCryptoRestDataSourceImpl implements HttpCryptoRestDataSource {
  @override
  HttpCryptoRestDataSourceApi api;

  HttpCryptoRestDataSourceImpl({required this.api});

  @override
  Future<List<HttpRestCrypto>> getCryptocurrencies(int count) async {
    final response = await api.getCryptocurrencies(count);

    return response.cryptocurrencyResponseDataList.map((elem) => HttpRestCrypto.fromResponse(elem)).toList();
  }
}