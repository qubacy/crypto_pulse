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

  @override
  bool operator==(Object other) {
    if (other is! CryptocurrencyResponseData) return false;

    return (
      other.name == name &&
      other.symbol == symbol &&
      other.quote == quote
    );
  }

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

  @override
  int get hashCode => Object.hash(name, symbol, quote);
}

class QuoteResponseData {
  static const USD_PROP_NAME = "USD";

  final USDQuoteResponseData usd;

  QuoteResponseData({required this.usd});

  @override
  bool operator==(Object other) {
    if (other is! QuoteResponseData) return false;

    return (
      other.usd == usd
    );
  }

  factory QuoteResponseData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        USD_PROP_NAME: Map<String, dynamic> usdQuoteJson
      } => QuoteResponseData(usd: USDQuoteResponseData.fromJson(usdQuoteJson)),
      _ => throw FormatException()
    };
  }

  @override
  int get hashCode => usd.hashCode;
}

class USDQuoteResponseData {
  static const PRICE_PROP_NAME = "price";
  static const MARKET_CUP_PROP_NAME = "market_cap";

  final double price;
  final double marketCap;

  USDQuoteResponseData({required this.price, required this.marketCap});

  @override
  bool operator==(Object other) {
    if (other is! USDQuoteResponseData) return false;

    return (
      other.price == price && 
      other.marketCap == marketCap
    );
  }

  factory USDQuoteResponseData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        PRICE_PROP_NAME: double price,
        MARKET_CUP_PROP_NAME: double marketCup
      } => USDQuoteResponseData(price: price, marketCap: marketCup),
      _ => throw FormatException()
    };
  }

  @override
  int get hashCode => Object.hash(price, marketCap);
}