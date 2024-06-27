import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import '../_common/LocalTokenEnvironmentDataSource.dart';

@Injectable(as: LocalTokenEnvironmentDataSource)
class LocalTokenEnvironmentDataSourceImpl extends LocalTokenEnvironmentDataSource {
  LocalTokenEnvironmentDataSourceImpl({required DotEnv dotEnv}) {
    super.dotEnv = dotEnv;
  }

  @override
  Future<String> loadToken() {
    return Future.value(dotEnv.get(LocalTokenEnvironmentDataSource.TOKEN_ENV_PROP_NAME));
  }
}