import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DotEnvModule {
  @preResolve
  Future<DotEnv> dotEnv() async {
    final dotEnv = DotEnv();
    
    // todo: doesnt work in Isolate:
    await dotEnv.load();

    print("dotEnv(): after");

    return dotEnv;
  }
}