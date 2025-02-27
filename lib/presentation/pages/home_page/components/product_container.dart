import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vcartpi/data/models/product_count_money.dart';

// ignore: must_be_immutable
class Product extends StatelessWidget {
  ProductCountMoneyModel product;
  int numbers;
  Map<String, Color> colorInUsed;

  Product(
      {super.key,
      required this.product,
      required this.numbers,
      required this.colorInUsed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(5),
        margin:
            EdgeInsets.symmetric(horizontal: 5, vertical: 5), // ✅ Giảm margin
        width: double.infinity, // ✅ Để Grid quản lý chiều rộng
        height: 248,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: colorInUsed["grid"]!),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image san pham
            Container(
                margin: EdgeInsets.all(5), // ✅ Giảm margin hình ảnh
                width: 100,
                height: 80,
                child: SvgPicture.asset(
                  product.imgUrl,
                  fit: BoxFit.contain,
                )),
            // Shadow
            ClipOval(
              child: Container(
                width: 191,
                height: 18,
                decoration: BoxDecoration(color: Colors.grey.shade300),
              ),
            ),
            // Divider
            Divider(
              color: colorInUsed["grid"],
              thickness: 1,
              indent: 15, // ✅ Giảm khoảng cách divider
              endIndent: 15,
            ),
            // Tên sản phẩm
            Text(product.name,
                style: TextStyle(
                    color: colorInUsed["text"], fontSize: 16)), // ✅ Giảm font
            // Giá và số lượng
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Đơn giá : ${product.value ~/ numbers}.000đ",
                    style: TextStyle(
                        color: colorInUsed["text"],
                        fontSize: 16)), // ✅ Giảm font
                Text("Số lượng : $numbers",
                    style: TextStyle(
                        color: colorInUsed["text"],
                        fontSize: 16)), // ✅ Giảm font
              ],
            ),
          ],
        ),
      ),
    );
  }
}
