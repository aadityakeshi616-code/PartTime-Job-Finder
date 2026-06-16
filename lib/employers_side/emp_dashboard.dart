import 'package:flutter/material.dart';
import 'job_post_screen.dart';
import 'my_applicants.dart';



class EmpDashboard extends StatefulWidget {
  final Map<String, dynamic> user;

  const EmpDashboard({super.key, required this.user});

  @override
  State<EmpDashboard> createState() => EmpDashboardState();
}

class EmpDashboardState extends State<EmpDashboard> {

  int currentIndex = 0; // 🔥 0 = Post Job default

  @override
  Widget build(BuildContext context) {

    final loggedInUser = widget.user;

    final screens = [
      PostJobScreen(user: loggedInUser),        // 🔥 Default screen
      MyApplicantsScreen(user: loggedInUser),  // 🔥 Applicants
    ];

    return Scaffold(

      // ❌ AppBar yaha mat daalo (screens ka apna hoga)
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
            icon: Icon(Icons.add_box),
            label: "Post Job",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Applicants",
          ),
        ],
      ),
    );
  }
}