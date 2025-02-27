import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  Map<String, Color> colorOfHomePage = {};
  Map<String, Map<String, String>> textLanguage = {};
  bool isDarkMode = false;
  bool isVietnamese = true;

  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.light_mode),
      WidgetState.any: Icon(Icons.dark_mode),
    },
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: (isDarkMode)
          ? const Color.fromARGB(255, 29, 58, 44)
          : Colors.greenAccent,
      actions: [
        _createActionsAppbar(),
        // Avatar
        _createAvatar(),
        SizedBox(width: 20),
      ],
    );
  }

  SizedBox _createActionsAppbar() {
    return SizedBox(
      child: Row(
        children: [
          // Switcher
          Switch(
              thumbIcon: thumbIcon,
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              }),
          SizedBox(width: 200),
          // Buttons
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 73,
              height: 52,
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/menu.svg",
                      semanticsLabel: 'Icon'),
                  Text("${textLanguage["appbar"]!["trangchu"]}",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 90,
              height: 52,
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/tag.svg"),
                  Text(
                    "${textLanguage["appbar"]!["khuyenmai"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 90,
              height: 52,
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/chamthan.svg"),
                  Text(
                    "${textLanguage["appbar"]!["huongdan"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 100),
          // Flag
          InkWell(
            onTap: () {
              setState(() {
                isVietnamese = !isVietnamese;
              });
            },
            child: SizedBox(
              width: 46,
              height: 46,
              child: SvgPicture.asset(
                  (isVietnamese)
                      ? "assets/icons/vnflag.svg"
                      : "assets/icons/usflag.svg",
                  semanticsLabel: 'Icon'),
            ),
          ),
          SizedBox(width: 20),
          Text("${textLanguage["banner"]!["xinchao"]}, Dai Phong",
              style: TextStyle(color: Colors.white)),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Stack _createAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          child: Image.asset("assets/icons/avatar.png", width: 60, height: 60),
        ),
        Container(
          width: 40,
          height: 30,
          alignment: Alignment.topRight,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 2, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
