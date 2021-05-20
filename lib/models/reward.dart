class Reward {
  String id;
  String owner;
  int points;
  String product;
  double priceOff;
  bool available;
  String category;

  Reward({
    this.id,
    this.owner,
    this.points,
    this.product,
    this.priceOff,
    this.available,
    this.category,
  });

  factory Reward.fromMap(Map data) {
    data = data ?? {};
    return Reward(
      id: data['id'] ?? '',
      owner: data['owner'] ?? '',
      points: data['points'] ?? 0,
      product: data['product'] ?? '',
      priceOff: data['priceOff'] ?? 0.0,
      available: data['available'] ?? false,
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'owner': this.owner,
      'points': this.points,
      'priceOff': this.priceOff,
      'product': this.product,
      'available': this.available,
      'category': this.category,
    };
  }
}
