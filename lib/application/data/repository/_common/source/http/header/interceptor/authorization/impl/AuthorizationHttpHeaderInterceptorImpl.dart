import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart';

import '../_common/AuthorizationHttpHeaderInterceptor.dart';

class AuthorizationHttpHeaderInterceptorImpl implements AuthorizationHttpHeaderInterceptor {
  final LocalTokenEnvironmentDataSource localTokenEnvironmentDataSource;

  AuthorizationHttpHeaderInterceptorImpl({required this.localTokenEnvironmentDataSource});

  @override
  Future<void> intercept(Map<String, String> headers) async {
    final token = await localTokenEnvironmentDataSource.loadToken();

    headers[AuthorizationHttpHeaderInterceptor.AUTHORIZATION_HEADER_NAME] = token;
  }
}