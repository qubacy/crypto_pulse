// Mocks generated by Mockito 5.4.4 from annotations
// in crypto_pulse/test/application/data/repository/_common/source/http/util/HttpDataSourceUtilTest.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart'
    as _i3;
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/_common/HttpHeaderInterceptor.dart'
    as _i6;
import 'package:flutter_dotenv/flutter_dotenv.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDotEnv_0 extends _i1.SmartFake implements _i2.DotEnv {
  _FakeDotEnv_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HttpContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpContext extends _i1.Mock implements _i3.HttpContext {
  MockHttpContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DotEnv get dotEnv => (super.noSuchMethod(
        Invocation.getter(#dotEnv),
        returnValue: _FakeDotEnv_0(
          this,
          Invocation.getter(#dotEnv),
        ),
      ) as _i2.DotEnv);

  @override
  set dotEnv(_i2.DotEnv? _dotEnv) => super.noSuchMethod(
        Invocation.setter(
          #dotEnv,
          _dotEnv,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<String> loadUri() => (super.noSuchMethod(
        Invocation.method(
          #loadUri,
          [],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #loadUri,
            [],
          ),
        )),
      ) as _i4.Future<String>);
}

/// A class which mocks [HttpHeaderInterceptor].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpHeaderInterceptor extends _i1.Mock
    implements _i6.HttpHeaderInterceptor {
  MockHttpHeaderInterceptor() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> intercept(Map<String, String>? headers) =>
      (super.noSuchMethod(
        Invocation.method(
          #intercept,
          [headers],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
