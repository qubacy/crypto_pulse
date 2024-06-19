import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';

import 'context/_common/HttpContext.dart';

abstract class HttpDataSource {
  late final HttpContext httpContext;
  late final List<HttpHeaderInterceptor> interceptors;

  HttpDataSource();
}