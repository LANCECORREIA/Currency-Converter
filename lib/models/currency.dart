class Currency {
  String? id;
  String price = '0.0';
  String symbol = '';
  String name = '';

  Currency(
      {this.id, required this.price, required this.symbol, required this.name});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      price: json['price'],
      symbol: json['symbol'],
      name: json['name'],
    );
  }
}
