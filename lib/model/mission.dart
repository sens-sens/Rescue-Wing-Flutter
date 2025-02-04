import 'package:cloud_firestore/cloud_firestore.dart';

class Mission {
  final Timestamp date;
  final num latitude;
  final String packageType;
  final num missionId;
  final num longitude;

  Mission({
    required this.date,
    required this.latitude,
    required this.packageType,
    required this.missionId,
    required this.longitude,
  });

  
  factory Mission.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Mission(
      date: data['date'] as Timestamp,
      latitude: data['latitude'] as num,
      packageType: data['package_type'] as String,
      missionId: data['mission_id'] as num,
      longitude: data['longitude'] as num,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'latitude': latitude,
      'package_type': packageType,
      'mission_id': missionId,
      'longitude': longitude,
    };
  }
}
