import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DotEnvModule {
  @preResolve
  Future<DotEnv> dotEnv() async {
    final dotEnv = DotEnv();

    await dotEnv.load();

    print("dotEnv(): after");

    return dotEnv;
  }
}