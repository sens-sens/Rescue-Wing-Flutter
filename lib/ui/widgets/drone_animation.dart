import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DroneAnimation extends StatelessWidget {
  final bool animate;

  const DroneAnimation({required this.animate, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: 270,
      child: Lottie.asset(
        "lib/assets/lottie/drone.json",
        reverse: true,
        animate: animate,
      ),
    );
  }
}
