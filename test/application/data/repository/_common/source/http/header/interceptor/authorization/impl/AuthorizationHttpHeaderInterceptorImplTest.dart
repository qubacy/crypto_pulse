import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/impl/AuthorizationHttpHeaderInterceptorImpl.dart';
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'AuthorizationHttpHeaderInterceptorImplTest.mocks.dart';

@GenerateMocks([LocalTokenEnvironmentDataSource])
void main() {
  group('Authorization Http Header Interceptor Implementation test', () {
    test('Testing intercept() method', () async {
      String expectedToken = 'test';
      Map<String, String> headers = {};

      MockLocalTokenEnvironmentDataSource localTokenEnvironmentDataSourceMock = MockLocalTokenEnvironmentDataSource();

      when(localTokenEnvironmentDataSourceMock.loadToken()).thenAnswer((_) async => expectedToken);

      final authorizationHttpHeaderInterceptorImpl = AuthorizationHttpHeaderInterceptorImpl(
        localTokenEnvironmentDataSource: localTokenEnvironmentDataSourceMock
      );
      
      await authorizationHttpHeaderInterceptorImpl.intercept(headers);

      final gottenToken = headers[AuthorizationHttpHeaderInterceptor.AUTHORIZATION_HEADER_NAME];

      expect(gottenToken, expectedToken);
    });
  });
}