import 'package:flutter/material.dart';
import 'package:vcartpi/data/models/discount.dart';
import 'package:vcartpi/data/models/discount_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DiscountPart extends StatefulWidget {
  const DiscountPart({super.key});

  @override
  State<DiscountPart> createState() => _DiscountPartState();
}

class _DiscountPartState extends State<DiscountPart> {
  final List<String> imageList = [
    "assets/images/discount1.png",
    "assets/images/discount2.png",
    "assets/images/discount3.png",
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Discount>>(
        future: fetchDiscount(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: SizedBox(
                  width: 310,
                  height: 200,
                  child: CarouselSlider(
                      items: imageList
                          .map((e) => ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      e,
                                      fit: BoxFit.cover,
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ))),
            );
          } else {
            return Center();
          }
        });
  }
}
