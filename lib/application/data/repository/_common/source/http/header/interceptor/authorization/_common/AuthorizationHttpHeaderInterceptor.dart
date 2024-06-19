import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';

abstract class AuthorizationHttpHeaderInterceptor implements HttpHeaderInterceptor {
  static const String AUTHORIZATION_HEADER_NAME = "X-CMC_PRO_API_KEY";
}