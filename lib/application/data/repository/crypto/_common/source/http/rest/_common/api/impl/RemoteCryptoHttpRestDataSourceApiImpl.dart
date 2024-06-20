import 'dart:convert';

import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/util/HttpDataSourceUtil.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';
import 'package:http/http.dart' as http;

import '../_common/RemoteCryptoHttpRestDataSourceApi.dart';

class RemoteCryptoHttpRestDataSourceApiImpl implements RemoteCryptoHttpRestDataSourceApi {
  @override
  HttpContext httpContext;
  @override
  List<HttpHeaderInterceptor> interceptors;

  RemoteCryptoHttpRestDataSourceApiImpl({required this.httpContext, required this.interceptors});

  @override
  Future<GetCryptocurrenciesResponse> getCryptocurrencies(int count) async {
    final uri = HttpDataSourceUtil.getFullUri(httpContext, "/v1/cryptocurrency/listings/latest");
    final headers = await HttpDataSourceUtil.applyHeaderInterceptors(headerInterceptors: interceptors);
    final response = await http.get(uri, headers: headers);
    final responseBodyJson = jsonDecode(response.body);

    return GetCryptocurrenciesResponse.fromJson(responseBodyJson);
  }
}