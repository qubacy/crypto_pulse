import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/context/impl/HttpContextImpl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'HttpContextImplTest.mocks.dart';

@GenerateMocks([DotEnv])
void main() {
  group('Testing HttpContextImpl', () {
    test('Correct Base Uri should be given', () async {      
      const expectedUri = 'test';

      const envMapMock = {HttpContext.BASE_URI_ENV_PROP_NAME: expectedUri};

      MockDotEnv dotEnvMock = MockDotEnv();

      when(dotEnvMock.env).thenAnswer((_) => envMapMock);

      final httpContext = HttpContextImpl(dotEnv: dotEnvMock);

      final gottenUri = await httpContext.loadUri();

      expect(gottenUri, expectedUri);
    });
  });
}