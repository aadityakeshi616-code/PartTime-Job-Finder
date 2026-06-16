import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:earnmate/login.dart';

import '../db_helper.dart';
import 'job_model.dart';

class StuDashboard extends StatefulWidget{
  final Map<String, dynamic> user;
  const StuDashboard({super.key, required this.user});

  @override
  State<StatefulWidget> createState() {
    return StuDashboardState();
  }
}

class StuDashboardState extends State<StuDashboard> {

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  //New Controller for Search BAR
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allJobs = [];
  List<Map<String, dynamic>> filteredJobs = [];

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  //New Funtion for load jobs
  void loadJobs() async {
    var jobs = await dbHelper.getJobs();
    setState(() {
      allJobs = jobs;
      filteredJobs = jobs;
    });
  }

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: const [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8),
            Text("Logout"),
          ],
        ),
        content: const Text("Are you sure you want to logout?"),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                    (route) => false,
              );
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  //New Function for Search
  void searchJobs(String query) {
    final results = allJobs.where((job) {
      final title = job['title'].toString().toLowerCase();
      final location = job['location'].toString().toLowerCase();
      final type = job['type'].toString().toLowerCase();
      final company = job['company'].toString().toLowerCase();
      return title.contains(query.toLowerCase()) ||
          location.contains(query.toLowerCase()) ||
          type.contains(query.toLowerCase()) ||
          company.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredJobs = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [

          // 🔥 TOP HEADER (GRADIENT)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text(
                      "EarnMate",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),

                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        logout(context);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  "Hello, ${widget.user['name']} 👋",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Find Part-time Jobs around you",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 15),

                // 🔍 SEARCH BAR
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    searchJobs(value); // 🔥 SAME FUNCTION
                  },
                  decoration: InputDecoration(
                    hintText: "Search jobs...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 JOB LIST
          Expanded(
            child: filteredJobs.isEmpty
                ? const Center(child: Text("No Jobs Found"))
                : ListView.builder(
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                var job = filteredJobs[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // 🔥 TOP ROW
                      Row(
                        children: [

                          // ICON
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.work, color: Colors.purple),
                          ),

                          const SizedBox(width: 10),

                          // TITLE + COMPANY
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  job['title'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  job['company'],
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),

                          // 💰 SALARY
                          Text(
                            "₹${job['salary']}",
                            style: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // 📍 LOCATION
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 14, color: Colors.purple),
                          const SizedBox(width: 5),
                          Text(job['location']),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // 🔥 TAGS + BUTTON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // TAGS
                          Row(
                            children: [

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  job['type'] ?? "Part-time",
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.purple),
                                ),
                              ),

                              const SizedBox(width: 5),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "On-site",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green),
                                ),
                              ),
                            ],
                          ),

                          // 🔥 BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/job_details',
                                arguments: {
                                  'job': Job.fromMap(job),
                                  'user': widget.user
                                },
                              );
                            },
                            child: const Text("View Details",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
