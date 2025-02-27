import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgToggleSwitch extends StatefulWidget {
  const SvgToggleSwitch({super.key});

  @override
  State<SvgToggleSwitch> createState() => _SvgToggleSwitchState();
}

class _SvgToggleSwitchState extends State<SvgToggleSwitch> {
  // Biến trạng thái: true nghĩa là "on", false nghĩa là "off"
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Khi bấm vào, đổi trạng thái
        setState(() {
          isOn = !isOn;
        });
      },
      child: Container(
        width: 105,
        height: 40,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isOn ? Colors.green[300] : Colors.grey[400],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            // Widget AnimatedPositioned để di chuyển nút chuyển
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isOn ? 60 : 0,
              right: isOn ? 0 : 60,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                // Sử dụng AnimatedSwitcher để chuyển đổi SVG tùy trạng thái
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isOn
                      ? SvgPicture.asset(
                          'assets/images/pie.svg',
                          key: const ValueKey('on'),
                          width: 20,
                          height: 40,
                        )
                      : SvgPicture.asset(
                          'assets/images/pie.svg',
                          key: const ValueKey('off'),
                          width: 20,
                          height: 20,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
