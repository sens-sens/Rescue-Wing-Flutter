import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rescue_wing/model/mission.dart';

import '../model/drone_status.dart';

class FirebaseServices {
  static toggleConnectionState(bool value) {
    FirebaseDatabase.instance.ref().child("is_connected").set(!value);
  }

  static startDrone() {
    FirebaseDatabase.instance.ref().child("start").set(true);
  }

  static setPackageId(num packageId) {
    FirebaseDatabase.instance.ref().child("package_id").set(packageId);
  }

  static addNewMission(Mission mission) async {
    await FirebaseFirestore.instance.collection('missions').add({
      'mission_id': mission.missionId,
      'package_type': mission.packageType,
      'date': mission.date,
      'latitude': mission.latitude,
      'longitude': mission.longitude,
    });
  }

  static turnOffDrone() {
    FirebaseDatabase.instance.ref().child("start").set(false);
  }

  static changeAltitude(num altitude) {
    FirebaseDatabase.instance.ref().child("altitude").set(altitude.toInt());
  }

  static setHomeLocation(Location locationData) {
    FirebaseDatabase.instance.ref().child("home").set(locationData.toMap());
  }

  static setTargetLocation(Location locationData) {
    FirebaseDatabase.instance.ref().child("target").set(locationData.toMap());
  }

  static Future<Location> getHomeLocation() async {
    Location location = Location(lon: 0, lat: 0);
    await FirebaseDatabase.instance
        .ref()
        .child("home")
        .get()
        .then((DataSnapshot value) async {
      location =
          Location.fromMap(Map<String, dynamic>.from(value.value as Map));
    });
    return location;
  }

  static Future<Location> getTargetLocation() async {
    Location location = Location(lon: 0, lat: 0);
    await FirebaseDatabase.instance
        .ref()
        .child("target")
        .get()
        .then((DataSnapshot value) async {
           location =
          Location.fromMap(Map<String, dynamic>.from(value.value as Map));
    });
    return location;
  }
}
