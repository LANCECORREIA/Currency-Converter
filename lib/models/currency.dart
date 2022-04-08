class Currency {
  String? id;
  String price = '0.0';
  String symbol;
  String name;
  String rank;

  Currency(
      {this.id,
      required this.price,
      required this.symbol,
      required this.name,
      required this.rank});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      price: json['price'],
      symbol: json['symbol'],
      name: json['name'],
      rank: json['rank'],
    );
  }
}
