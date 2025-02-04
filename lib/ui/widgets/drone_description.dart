import 'package:flutter/material.dart';

class DroneDescription extends StatelessWidget {
  const DroneDescription({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Angry Bird",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        Text(
          "Mzcet Aircraft",
          style: TextStyle(
            color: Color.fromARGB(255, 190, 182, 182),
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
