enum DroneMode {
  fly,
  hold,
  park,
}

DroneMode droneModeFromString(String mode) {
  switch (mode) {
    case 'fly':
      return DroneMode.fly;
    case 'hold':
      return DroneMode.hold;
    case 'park':
      return DroneMode.park;
    default:
      throw Exception('Invalid drone mode: $mode');
  }
}

String droneModeToString(DroneMode mode) {
  switch (mode) {
    case DroneMode.fly:
      return 'fly';
    case DroneMode.hold:
      return 'hold';
    case DroneMode.park:
      return 'park';
  }
}

class DroneStatus {
  final bool drop;
  final bool isConnected;
  final num altitude;
  final num currentLat;
  final bool start;
  final num packageId;
  final num battery;
  final num speed;
  final Location home;
  final Location target;
  final DroneMode mode;
  final num currentAlt;
  final num currentLon;

  DroneStatus({
    required this.drop,
    required this.isConnected,
    required this.altitude,
    required this.currentLat,
    required this.start,
    required this.packageId,
    required this.battery,
    required this.speed,
    required this.home,
    required this.target,
    required this.mode,
    required this.currentAlt,
    required this.currentLon,
  });
  
  factory DroneStatus.fromMap(Map<Object?, Object?> data) {
    return DroneStatus(
      drop: data['drop'] as bool,
      isConnected: data['is_connected'] as bool,
      altitude: data['altitude'] as num,
      currentLat: data['current_lat'] as num,
      start: data['start'] as bool,
      packageId: data['package_id'] as num,
      battery: data['battery'] as num,
      speed: data['speed'] as num,
      home: Location.fromMap(Map<String, dynamic>.from(data['home'] as Map)),
      target: Location.fromMap(Map<String, dynamic>.from(data['target'] as Map)),
      mode: droneModeFromString(data['mode'] as String),
      currentAlt: data['current_alt'] as num,
      currentLon: data['current_lon'] as num,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'drop': drop,
      'is_connected': isConnected,
      'altitude': altitude,
      'current_lat': currentLat,
      'start': start,
      'package_id': packageId,
      'battery': battery,
      'speed': speed,
      'home': home.toMap(),
      'target': target.toMap(),
      'mode': droneModeToString(mode),
      'current_alt': currentAlt,
      'current_lon': currentLon,
    };
  }
}

class Location {
  final num lon;
  final num lat;

  Location({
    required this.lon,
    required this.lat,
  });

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      lon: data['lon'],
      lat: data['lat'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}
