class Reward {
  String id;
  String owner;
  String points; // parsing method will make it easy to convert in to int
  String product;
  bool available;
  String category;
  String coupon;

  Reward({
    this.id,
    this.owner,
    this.points,
    this.product,
    this.available,
    this.category,
    this.coupon,
  });

  factory Reward.fromMap(Map data) {
    data = data ?? {};
    return Reward(
      id: data['id'] ?? '',
      owner: data['owner'] ?? '',
      points: data['points'] ?? '',
      product: data['product'] ?? '',
      available: data['available'] ?? false,
      category: data['category'] ?? '',
      coupon: data['coupon'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'owner': this.owner,
      'points': this.points,
      'product': this.product,
      'available': this.available,
      'category': this.category,
      'coupon': this.coupon,
    };
  }
}
