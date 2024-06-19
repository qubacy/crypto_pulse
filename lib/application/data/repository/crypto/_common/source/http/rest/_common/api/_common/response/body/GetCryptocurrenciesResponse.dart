import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';

class GetCryptocurrenciesResponse {
  static const DATA_PROP_NAME = "data";

  final List<CryptocurrencyResponseData> cryptocurrencyResponseDataList;

  GetCryptocurrenciesResponse({required this.cryptocurrencyResponseDataList});

  factory GetCryptocurrenciesResponse.fromJson(Map<String, dynamic> json) {
    final List<CryptocurrencyResponseData> dataList = json[DATA_PROP_NAME]
      .map((itemJson) => CryptocurrencyResponseData.fromJson(itemJson));

    return GetCryptocurrenciesResponse(cryptocurrencyResponseDataList: dataList);
  }
}