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
    List<ProductCountMoneyModel> listProducts = [];
    listProducts.add(ProductCountMoneyModel(
        numbers: 1,
        name: "Pancake",
        value: 35,
        imgUrl: "assets/images/pie.svg"));
    return listProducts;
  }
}
