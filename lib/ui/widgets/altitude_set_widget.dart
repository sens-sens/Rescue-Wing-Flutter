import 'package:flutter/material.dart';
import '../../core/constants.dart';

class AltitudeSetWidget extends StatelessWidget {
  final num altitude;
  final Function(double)? onChanged;

  const AltitudeSetWidget({
    required this.onChanged,
    required this.altitude,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Constants.containerColor,
        borderRadius: Constants.containerBorderRadius,
      ),
      child: Column(
        children: [
          const SizedBox(height: 15,),
          const Center(
            child: Text(
              "HEIGHT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Text(
            "${altitude.truncateToDouble()} M",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          Slider(
            inactiveColor: Colors.black,
            activeColor: Colors.red,
            value: altitude.toDouble(),
            onChanged: onChanged,
            min: 0,
            max: 10.0,
          )
        ],
      ),
    );
  }
}
