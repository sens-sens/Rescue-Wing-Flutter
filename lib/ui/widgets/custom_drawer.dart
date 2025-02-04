import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rescue_wing/ui/pages/map_viewer.dart';
import 'package:rescue_wing/utility/utility.dart';

import '../../core/constants.dart';
import '../../model/drone_status.dart';
import '../../services/firebase_services.dart';
import 'custom_text_field.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  openHomeLocation(context) async {
    Location homeLocation = await FirebaseServices.getHomeLocation();
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/${homeLocation.lat},${homeLocation.lon}',
    );
    if (kDebugMode) {
      print(url);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapViewer(
            url: url,
          ),
        ));
  }

  openTargetLocation(context) async {
    Location targetLocation = await FirebaseServices.getTargetLocation();
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/${targetLocation.lat},${targetLocation.lon}',
    );
    if (kDebugMode) {
      print(url);
    }
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapViewer(
            url: url,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setHomeDialog(context);
              },
              child: const Text(
                'Set Home',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                openHomeLocation(context);
              },
              child: const Text(
                'View Home',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                openTargetLocation(context);
              },
              child: const Text(
                'View Target',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setHomeDialog(context) {
    TextEditingController longitude = TextEditingController();
    TextEditingController latitude = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          height: 300,
          width: 250,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: Constants.containerBorderRadius,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey.shade900,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Set Home location',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(controller: latitude, label: "Latitude"),
                CustomTextField(controller: longitude, label: "Longitude"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Location location = Location(
                          lon: Utility.parseNumber(longitude.text),
                          lat: Utility.parseNumber(latitude.text),
                        );
                        FirebaseServices.setHomeLocation(location);

                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
