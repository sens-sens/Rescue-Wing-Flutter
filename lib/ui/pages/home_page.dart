import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'missions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<Widget> pages = const [DashBoardPage(), MissionsPage()];
  changePage(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        currentIndex: index,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(label: 'Mission', icon: Icon(Icons.bar_chart)),
        ],
      ),
    );
  }
}
