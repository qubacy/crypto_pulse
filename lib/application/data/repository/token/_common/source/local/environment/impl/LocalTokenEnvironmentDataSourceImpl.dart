import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../_common/LocalTokenEnvironmentDataSource.dart';

class LocalTokenEnvironmentDataSourceImpl extends LocalTokenEnvironmentDataSource {
  LocalTokenEnvironmentDataSourceImpl();

  @override
  Future<String> loadToken() {
    return Future.value(DotEnv().get(LocalTokenEnvironmentDataSource.TOKEN_ENV_PROP_NAME));
  }
}