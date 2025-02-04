import 'package:flutter/material.dart';

class TakeOffButton extends StatelessWidget {
  const TakeOffButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: const Row(
        
        children: [
          SizedBox(width: 15,),
          Text(
            "TAKE OFF",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Icon(
            Icons.chevron_right,
            size: 35,
          )
        ],
      ),
    );
  }
}
