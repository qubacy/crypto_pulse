import 'dart:convert';

import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/util/HttpDataSourceUtil.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../_common/RemoteCryptoHttpRestDataSourceApi.dart';

@Injectable(as: RemoteCryptoHttpRestDataSourceApi)
class RemoteCryptoHttpRestDataSourceApiImpl implements RemoteCryptoHttpRestDataSourceApi {
  @override
  http.Client httpClient;
  @override
  HttpContext httpContext;
  @override
  List<HttpHeaderInterceptor> interceptors;

  RemoteCryptoHttpRestDataSourceApiImpl({
    required this.httpClient, 
    required this.httpContext, 
    required AuthorizationHttpHeaderInterceptor authorizationHttpHeaderInterceptor
  }) : interceptors = [authorizationHttpHeaderInterceptor];

  @override
  Future<GetCryptocurrenciesResponse> getCryptocurrencies(int count) async {
    final uri = await HttpDataSourceUtil.getFullUri(httpContext, "/v1/cryptocurrency/listings/latest");
    final headers = await HttpDataSourceUtil.applyHeaderInterceptors(headers: {}, headerInterceptors: interceptors);
    final response = await httpClient.get(uri, headers: headers);
    final responseBodyJson = jsonDecode(response.body);

    return GetCryptocurrenciesResponse.fromJson(responseBodyJson);
  }
}