import 'package:crypto_pulse/application/data/repository/_common/source/http/api/HttpDataSourceApi.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';

abstract class RemoteCryptoHttpRestDataSourceApi extends HttpDataSourceApi {
  RemoteCryptoHttpRestDataSourceApi();

  Future<GetCryptocurrenciesResponse> getCryptocurrencies(int count);
}