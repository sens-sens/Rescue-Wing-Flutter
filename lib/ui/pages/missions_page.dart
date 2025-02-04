import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rescue_wing/ui/widgets/custom_text_field.dart';

import '../../core/constants.dart';
import '../../model/drone_status.dart';
import '../../model/mission.dart';
import '../../services/firebase_services.dart';

import '../../utility/utility.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/mission_tile.dart';
import '../widgets/qr_scanner.dart';

class MissionsPage extends StatefulWidget {
  const MissionsPage({super.key});

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrScanner(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomSearchBar(
              onSearchChanged: ((value) => setState(() {
                    searchText = value;
                  })),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('missions')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    children: snapshot.data!.docs
                        .where((element) => element['mission_id']
                            .toString()
                            .contains(searchText))
                        .map<Widget>((doc) {
                      Mission mission = Mission.fromFirestore(doc);
                      return MissionTile(
                        onTap: () {
                          Location location = Location(
                            lon: mission.longitude,
                            lat: mission.latitude,
                          );
                          setTarget(
                            location,
                            mission.missionId,
                          );
                        },
                        mission: mission,
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewMission,
        child: const Icon(Icons.add),
      ),
    );
  }

  setTarget(Location locationData, num missionId) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          height: 200,
          width: 250,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: Constants.containerColor,
            borderRadius: Constants.containerBorderRadius,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Do you want to set target for mission # $missionId?',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        FirebaseServices.setTargetLocation(locationData);

                        FirebaseServices.setPackageId(missionId);
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
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


  void addNewMission() {
    TextEditingController packageType = TextEditingController();
    TextEditingController missionId = TextEditingController();
    TextEditingController longitude = TextEditingController();
    TextEditingController latitude = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          height: 500,
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
                  'Add new Mission',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(controller: missionId, label: "Mission ID"),
                CustomTextField(controller: packageType, label: "Package type"),
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
                        Mission mission = Mission(
                          date:Timestamp.fromDate(DateTime.now()),
                          latitude: Utility.parseNumber(latitude.text),
                          packageType: packageType.text,
                          missionId: Utility.parseNumber(missionId.text),
                          longitude: Utility.parseNumber(longitude.text),
                        );
                        FirebaseServices.addNewMission(mission);

                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
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
