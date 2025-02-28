class Product {
  final int productId;
  final String productName;
  final int price;
  final String description;
  final int quantity;
  final String urlImage;

  Product({
    required this.productId,
    required this.productName,
    required this.price,
    required this.description,
    required this.quantity,
    required this.urlImage,
  });

  // Hàm chuyển đổi từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      urlImage: json['url_image'] as String? ?? '', // Xử lý trường hợp null
    );
  }

  @override
  String toString() =>
      '{id : $productId ; name : $productName ; price : $price ; description : $description ; url_image : $urlImage ;}';
}
