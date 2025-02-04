import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SpeedIndicator extends StatelessWidget {
  final num speed;

  const SpeedIndicator({required this.speed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircularPercentIndicator(
              radius: 45.0,
              startAngle: 225,
              backgroundColor: Colors.black,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              percent: 0.75,
              progressColor: Colors.grey.shade800,
            ),
            CircularPercentIndicator(
              radius: 45.0,
              startAngle: 225,
              backgroundColor: Colors.transparent,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              percent: speed / 13.333,
              center: Text(
                speed.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              progressColor: Colors.red,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Speed km/hr",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
