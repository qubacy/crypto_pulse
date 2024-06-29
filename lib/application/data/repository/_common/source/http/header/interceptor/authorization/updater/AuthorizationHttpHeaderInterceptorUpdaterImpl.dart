import '../_common/AuthorizationHttpHeaderInterceptor.dart';

class AuthorizationHttpHeaderInterceptorUpdaterImpl implements AuthorizationHttpHeaderInterceptor {
  final String token;

  AuthorizationHttpHeaderInterceptorUpdaterImpl({required this.token});

  @override
  Future<void> intercept(Map<String, String> headers) async {
    headers[AuthorizationHttpHeaderInterceptor.AUTHORIZATION_HEADER_NAME] = token;
  }
}