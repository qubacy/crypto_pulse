import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart';

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:injectable/injectable.dart';

import '../_common/RemoteCryptoHttpRestDataSource.dart';

@Injectable(as: RemoteCryptoHttpRestDataSource)
class RemoteCryptoHttpRestDataSourceImpl implements RemoteCryptoHttpRestDataSource {
  @override
  RemoteCryptoHttpRestDataSourceApi api;

  RemoteCryptoHttpRestDataSourceImpl({required this.api});

  @override
  Future<List<RemoteHttpRestCrypto>> getCryptocurrencies(int count) async {
    final response = await api.getCryptocurrencies(count);

    return response.cryptocurrencyResponseDataList.map((elem) => RemoteHttpRestCrypto.fromResponse(elem)).toList();
  }
}