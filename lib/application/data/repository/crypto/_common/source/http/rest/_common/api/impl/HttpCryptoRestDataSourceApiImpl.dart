import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/util/HttpDataSourceUtil.dart';
import 'package:http/http.dart' as http;

import '../_common/HttpCryptoRestDataSourceApi.dart';

class HttpCryptoRestDataSourceApiImpl implements HttpCryptoRestDataSourceApi {
  @override
  HttpContext httpContext;
  @override
  List<HttpHeaderInterceptor> interceptors;

  HttpCryptoRestDataSourceApiImpl({required this.httpContext, required this.interceptors});

  @override
  Future<http.Response> getCryptocurrencies(int count) async {
    final uri = HttpDataSourceUtil.getFullUri(httpContext, "/v1/cryptocurrency/listings/latest");
    final headers = await HttpDataSourceUtil.applyHeaderInterceptors(headerInterceptors: interceptors);

    return http.get(uri, headers: headers);
  }
}