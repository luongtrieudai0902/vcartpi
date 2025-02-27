import 'package:vcartpi/data/models/discount.dart';

Future<List<Discount>> fetchDiscount() async {
  var discountList = <Discount>[];

  var f1 =
      Discount(discountImageName: "assets/images/food/ChickenCurryPasta.jpg");
  var f2 =
      Discount(discountImageName: "assets/images/food/ExplosionBurger.jpg");
  var f3 = Discount(discountImageName: "assets/images/food/GrilledChicken.jpg");

  discountList.add(f1);
  discountList.add(f2);
  discountList.add(f3);

  return discountList;
}
