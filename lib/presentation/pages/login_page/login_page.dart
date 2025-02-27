import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vcartpi/presentation/pages/home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          children: [
            // Nơi đây chỉ để Logo
            Container(
                margin: EdgeInsets.all(50),
                width: 392,
                height: 392,
                decoration: BoxDecoration(
                  //color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logo_app.svg"),
                    Icon(Icons.car_crash)
                  ],
                )),
            // Nơi đây chứa mã QR và nút
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quét mã để bắt đầu mua sắm",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width: 256,
                      height: 256,
                      child: Image.asset("assets/images/QR.png")),
                  SizedBox(height: 20),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 318,
                      height: 51,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 212, 208, 208),
                      ),
                      child: Text("Chọn hình thức đăng nhập khác"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
