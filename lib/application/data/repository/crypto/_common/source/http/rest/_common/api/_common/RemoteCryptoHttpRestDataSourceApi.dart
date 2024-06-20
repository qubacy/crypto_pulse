import 'package:crypto_pulse/application/data/repository/_common/source/http/HttpDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';

abstract class RemoteCryptoHttpRestDataSourceApi extends HttpDataSource {
  RemoteCryptoHttpRestDataSourceApi();

  Future<GetCryptocurrenciesResponse> getCryptocurrencies(int count);
}