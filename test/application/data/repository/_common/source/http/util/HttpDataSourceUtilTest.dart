import 'dart:ffi';

import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/util/HttpDataSourceUtil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'HttpDataSourceUtilTest.mocks.dart';

@GenerateMocks([HttpContext, HttpHeaderInterceptor])
void main() {
  group('Http Data Source Util test', () {
    test('getFullUri() method test', () {
      const String baseUri = 'test.com';
      const String path = '/test';
      final MockHttpContext httpContextMock = MockHttpContext();

      when(httpContextMock.baseUri).thenReturn(baseUri);

      final Uri expectedFullUri = Uri.parse(baseUri + path);

      final Uri gottenFullUri = HttpDataSourceUtil.getFullUri(httpContextMock, path);

      expect(gottenFullUri, expectedFullUri);
    });

    test('applyHeaderInterceptors() method test', () {
      final Map<String, String> headers = {};

      final MockHttpHeaderInterceptor headerInterceptor = MockHttpHeaderInterceptor();

      when(headerInterceptor.intercept(any)).thenAnswer((_) async => Void);

      HttpDataSourceUtil.applyHeaderInterceptors(headerInterceptors: [headerInterceptor], headers: headers);

      verify(headerInterceptor.intercept(any));
    });
  });
}