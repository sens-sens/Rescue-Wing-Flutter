import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../core/constants.dart';


class BatteryStatusIndicator extends StatelessWidget {
  final int percentage;

  const BatteryStatusIndicator({
    required this.percentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Constants.containerColor,
        borderRadius: Constants.containerBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BATTERY STATUS",
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      percentage.toString(),
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    const Text(
                      " %",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    progressColor: Colors.orange,
                    animation: true,
                    lineHeight: 30,
                    percent: percentage / 100,
                    backgroundColor: Colors.black,
                    barRadius: const Radius.circular(10),
                  ),
                )
              ],
            ),
            const Text(
              "FEW SECS AGO",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
