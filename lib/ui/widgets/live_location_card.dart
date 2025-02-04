import 'package:flutter/material.dart';
import '../../core/constants.dart';

class LiveLocationCard extends StatefulWidget {
  final num latitude;
  final num altitude;
  final num longitude;
  final num packageId;

  const LiveLocationCard({
    required this.latitude,
    required this.altitude,
    required this.longitude,
    required this.packageId,
    super.key,
  });

  @override
  State<LiveLocationCard> createState() => _LiveLocationCardState();
}

class _LiveLocationCardState extends State<LiveLocationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        color: Constants.containerColor,
        borderRadius: Constants.containerBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Constants.containerBorderRadius,
              child: Image.asset("lib/assets/images/gmap.jpg"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            Label(text: "LAT : ${widget.latitude.toString()}"),
            Label(text: "LON : ${widget.longitude.toString()}"),
            Label(text: "ALT : ${widget.altitude.toString()}"),
            const Divider(
              color: Colors.grey,
            ),
            Label(
              text: "# ${widget.packageId.toString()}",
            )
          ],
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String text;
  const Label({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[200],
          fontSize: 14,
        ),
      ),
    );
  }
}
