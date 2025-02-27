class Product {
  final String product_id;
  final String product_name;
  final double price;
  final String description;
  final String url_image;

  Product(
      {required this.product_id,
      required this.product_name,
      required this.price,
      required this.description,
      required this.url_image});

  // Chuyển đổi từ JSON sang Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        product_id: json['product_id'],
        product_name: json['product_name'],
        description: json['product_description'],
        price: json['price'],
        url_image: json['url_image']);
  }
}
