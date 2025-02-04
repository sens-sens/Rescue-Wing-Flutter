import 'package:flutter/material.dart';
import '../../model/drone_status.dart';
import '../../core/constants.dart';

class ModesCard extends StatelessWidget {
  final DroneMode mode;
  const ModesCard({
    required this.mode,
    super.key,
  });

  String modeToText(DroneMode mode) {
    switch (mode) {
      case DroneMode.fly:
        return 'F';
      case DroneMode.hold:
        return 'H';
      case DroneMode.park:
        return 'P';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        color: Constants.containerColor,
        borderRadius: Constants.containerBorderRadius,
      ),
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "MODE",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(100)),
            child: Wrap(
              direction: Axis.horizontal,
              children: DroneMode.values.map((mode) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ModeIcon(
                    text: modeToText(mode),
                    isEnabled: this.mode == mode,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class ModeIcon extends StatelessWidget {
  final String text;
  final bool isEnabled;

  const ModeIcon({
    required this.text,
    required this.isEnabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: isEnabled ? Colors.grey.shade800 : Colors.black,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: isEnabled ? Colors.white : Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
