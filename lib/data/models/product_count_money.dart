class ProductCountMoneyModel {
  String name;
  int value;
  int numbers;
  String imgUrl;

  ProductCountMoneyModel({
    required this.name,
    required this.value,
    required this.numbers,
    required this.imgUrl,
  });

  static List<ProductCountMoneyModel> loadListProducts() {
    return [
      ProductCountMoneyModel(
        numbers: 1,
        name: "Pancake",
        value: 35,
        imgUrl: "assets/images/pie.svg",
      )
    ];
  }

  // Chuyển đổi danh sách JSON thành danh sách đối tượng
  static List<ProductCountMoneyModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductCountMoneyModel.fromJson(json))
        .toList();
  }

  // Chuyển đổi từ JSON thành đối tượng
  factory ProductCountMoneyModel.fromJson(Map<String, dynamic> json) {
    return ProductCountMoneyModel(
      name: json['name'] as String,
      value: json['value'] as int,
      numbers: json['numbers'] as int,
      imgUrl: json['imgUrl'] as String,
    );
  }
}
