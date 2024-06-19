class CryptocurrencyResponseData {
  final String name;
  final String symbol;
  final QuoteResponseData quote;

  CryptocurrencyResponseData({
    required this.name,
    required this.symbol,
    required this.quote
  });

  
}

class QuoteResponseData {
  final USDQuoteResponseData usd;

  QuoteResponseData({required this.usd});
}

class USDQuoteResponseData {
  final double marketCup;

  USDQuoteResponseData({required this.marketCup});
}