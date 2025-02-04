import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../widgets/altitude_set_widget.dart';
import '../widgets/battery_status_indicator.dart';
import '../widgets/drone_description.dart';
import '../widgets/live_location_card.dart';
import '../widgets/modes_card.dart';
import '../widgets/take_off_button.dart';
import '../widgets/connection_status_indicator.dart';
import '../widgets/drone_animation.dart';
import '../widgets/flight_time_indicator.dart';
import '../widgets/speed_indicator.dart';
import '../widgets/custom_drawer.dart';

import '../../model/drone_status.dart';
import '../../utility/utility.dart';
import '../../services/firebase_services.dart';
import '../../services/location_services.dart';

import '../../core/constants.dart';
import 'missions_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  @override
  void initState() {
    LocationServices.initialize();
    super.initState();
  }


  showStartDialog() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          height: 200,
          width: 250,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: Constants.containerBorderRadius,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Do you want to start the drone?',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseServices.turnOffDrone();
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseServices.startDrone();
                          Navigator.pop(context);
                        },
                        child: const Text('Yes')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Colors.black26,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MissionsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.health_and_safety),
              ),
            ),
          ],
        ),
        body: StreamBuilder<Object>(
            stream: FirebaseDatabase.instance.ref().onValue,
            builder: (context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              DroneStatus droneStatus =
                  DroneStatus.fromMap(snap.data.snapshot.value! as Map);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DroneDescription(),
                          ConnectionStatusIndicator(
                            isConnected: droneStatus.isConnected,
                            onLongPress: () {
                              FirebaseServices.toggleConnectionState(
                                droneStatus.isConnected,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DroneAnimation(animate: droneStatus.start),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SpeedIndicator(speed: droneStatus.speed),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlightTimeIndicator(
                          minutes: Utility.calculateRemainingFlightTime(
                            droneStatus.battery,
                          ),
                        ),
                        GestureDetector(
                          onTap: showStartDialog,
                          child: const TakeOffButton(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BatteryStatusIndicator(
                      percentage: Utility.calculateBatteryPercentage(
                        droneStatus.battery,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: LiveLocationCard(
                              altitude: droneStatus.altitude,
                              packageId: droneStatus.packageId,
                              latitude: droneStatus.currentLat,
                              longitude: droneStatus.currentLon,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                AltitudeSetWidget(
                                  onChanged: (value) async {
                                    if (droneStatus.mode == DroneMode.park) {
                                      FirebaseServices.changeAltitude(value);
                                    } else {
                                      Toast.show(
                                        "Cannot change altitude, Drone is in the air",
                                        duration: Toast.lengthLong,
                                        gravity: Toast.bottom,
                                      );
                                    }
                                  },
                                  altitude: droneStatus.altitude,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ModesCard(
                                  mode: droneStatus.mode,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
