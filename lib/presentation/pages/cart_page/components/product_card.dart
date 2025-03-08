import 'package:flutter/material.dart';
import 'package:vcartpi/core/utils/format_str.dart';
import 'package:vcartpi/data/models/product.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  Product productInfo;
  ProductCard({super.key, required this.productInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              height: 80,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // Image
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(right: 30),
                      width: 70,
                      height: 70,
                      child: Image.network(productInfo.urlImage
                          //"https://cdn-icons-png.flaticon.com/512/2578/2578721.png"
                          )),
                  // Info Product
                  SizedBox(
                    width: 850,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name of Product
                            Text(productInfo.description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            // Description
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${formatCurrency(productInfo.price)} Đ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500)),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: VerticalDivider(
                                    thickness: 1,
                                    indent: 1,
                                    endIndent: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Quanity : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text("${productInfo.quantity}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Price of product
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${formatCurrency(productInfo.price * productInfo.quantity)} Đ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              //height: 1.0,
              thickness: 3.0,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
