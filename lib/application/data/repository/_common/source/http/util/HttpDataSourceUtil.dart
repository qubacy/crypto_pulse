import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';

import '../header/interceptor/_common/HttpHeaderInterceptor.dart';

class HttpDataSourceUtil {
  static Uri getFullUri(HttpContext httpContext, String path) {
    return Uri.parse("${httpContext.baseUri}$path");
  }

  static Future<Map<String, String>> applyHeaderInterceptors({
    required Map<String, String> headers,
    required List<HttpHeaderInterceptor> headerInterceptors
  }) async {
    for (HttpHeaderInterceptor headerInterceptor in headerInterceptors) {
      await headerInterceptor.intercept(headers);
    }

    return headers;
  }
}