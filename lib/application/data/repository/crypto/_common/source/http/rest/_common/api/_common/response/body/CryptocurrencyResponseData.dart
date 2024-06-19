class CryptocurrencyResponseData {
  static const NAME_PROP_NAME = "name";
  static const SYMBOL_PROP_NAME = "symbol";
  static const QUOTE_PROP_NAME = "quote";

  final String name;
  final String symbol;
  final QuoteResponseData quote;

  CryptocurrencyResponseData({
    required this.name,
    required this.symbol,
    required this.quote
  });

  factory CryptocurrencyResponseData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        NAME_PROP_NAME: String name,
        SYMBOL_PROP_NAME: String symbol,
        QUOTE_PROP_NAME: Map<String, dynamic> quoteJson
      } => CryptocurrencyResponseData(name: name, symbol: symbol, quote: QuoteResponseData.fromJson(quoteJson)),
      _ => throw const FormatException()
    };
  }
}

class QuoteResponseData {
  static const USD_PROP_NAME = "usd";

  final USDQuoteResponseData usd;

  QuoteResponseData({required this.usd});

  factory QuoteResponseData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        USD_PROP_NAME: Map<String, dynamic> usdQuoteJson
      } => QuoteResponseData(usd: USDQuoteResponseData.fromJson(usdQuoteJson)),
      _ => throw FormatException()
    };
  }
}

class USDQuoteResponseData {
  static const PRICE_PROP_NAME = "price";
  static const MARKET_CUP_PROP_NAME = "market_cup";

  final double price;
  final double marketCup;

  USDQuoteResponseData({required this.price, required this.marketCup});

  factory USDQuoteResponseData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        PRICE_PROP_NAME: double price,
        MARKET_CUP_PROP_NAME: double marketCup
      } => USDQuoteResponseData(price: price, marketCup: marketCup),
      _ => throw FormatException()
    };
  }
}