import 'package:flutter/material.dart';

class FlightTimeIndicator extends StatelessWidget {
  final int minutes;
  const FlightTimeIndicator({required this.minutes, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Text(
            minutes.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 50),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MINS",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "FLYING LEFT",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
