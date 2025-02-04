import 'package:flutter/material.dart';
import '../../core/constants.dart';

class ConnectionStatusIndicator extends StatelessWidget {
  final bool isConnected;
  final Function() onLongPress;

  const ConnectionStatusIndicator({
    required this.isConnected,
    required this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String connectionStatusString = isConnected ? 'Connected' : 'Not Connected';
    return Column(
      children: [
        InkWell(
          onLongPress: onLongPress,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Constants.containerColor,
            child: isConnected
                ? const Icon(
                    Icons.wifi_outlined,
                    color: Color.fromARGB(255, 161, 255, 176),
                  )
                : const Icon(
                    Icons.wifi_off,
                    color: Color.fromARGB(255, 255, 108, 108),
                  ),
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          connectionStatusString,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
