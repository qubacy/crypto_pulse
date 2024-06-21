import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';
import 'package:http/http.dart' as http;

import '../context/_common/HttpContext.dart';

abstract class HttpDataSourceApi {
  late final http.Client httpClient;
  late final HttpContext httpContext;
  late final List<HttpHeaderInterceptor> interceptors;

  HttpDataSourceApi();
}