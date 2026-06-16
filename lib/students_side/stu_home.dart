import 'package:flutter/material.dart';
import 'myapplications.dart';
import 'stu_dashboard.dart'; // 👈


class StudentHome extends StatefulWidget {
  final Map<String, dynamic> user;

  const StudentHome({super.key, required this.user});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [
      StuDashboard(user: widget.user),          // 🔥 same dashboard
      MyApplicationsScreen(user: widget.user), // 🔥 applications
    ];

    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.purple,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: "Jobs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Applications",
          ),
        ],
      ),
    );
  }
}