import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';

class GetCryptocurrenciesResponse {
  static const DATA_PROP_NAME = "data";

  final List<CryptocurrencyResponseData> cryptocurrencyResponseDataList;

  const GetCryptocurrenciesResponse({required this.cryptocurrencyResponseDataList});

  @override
  bool operator==(Object other) {
    if (other is! GetCryptocurrenciesResponse) return false;

    if (other.cryptocurrencyResponseDataList.length != cryptocurrencyResponseDataList.length)
      return false;

    for (CryptocurrencyResponseData data in cryptocurrencyResponseDataList)
      if (!other.cryptocurrencyResponseDataList.contains(data)) return false;

    return true;
  }

  factory GetCryptocurrenciesResponse.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey(DATA_PROP_NAME)) throw FormatException();

    final cryptocurrencyDataJsonArray = json[DATA_PROP_NAME] as List;
    final List<CryptocurrencyResponseData> dataList = cryptocurrencyDataJsonArray
      .map((itemJson) => CryptocurrencyResponseData.fromJson(itemJson)).toList();

    return GetCryptocurrenciesResponse(cryptocurrencyResponseDataList: dataList);
  }

  @override
  int get hashCode => cryptocurrencyResponseDataList.hashCode;
}