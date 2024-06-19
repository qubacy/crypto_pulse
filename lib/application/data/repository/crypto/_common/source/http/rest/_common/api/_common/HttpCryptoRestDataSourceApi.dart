import 'package:crypto_pulse/application/data/repository/_common/source/http/HttpDataSource.dart';
import 'package:http/http.dart' as http;

abstract class HttpCryptoRestDataSourceApi extends HttpDataSource {
  HttpCryptoRestDataSourceApi();

  Future<http.Response> getCryptocurrencies(int count);
}