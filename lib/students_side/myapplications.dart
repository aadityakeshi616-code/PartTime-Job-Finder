import 'package:flutter/material.dart';
import '../db_helper.dart';
import 'job_model.dart';

class MyApplicationsScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const MyApplicationsScreen({super.key, required this.user});

  @override
  State<MyApplicationsScreen> createState() =>
      _MyApplicationsScreenState();
}

class _MyApplicationsScreenState
    extends State<MyApplicationsScreen> {

  late Future<List<Map<String, dynamic>>> appliedJobs;

  @override
  void initState() {
    super.initState();
    appliedJobs = DatabaseHelper.instance
        .getApplications(widget.user['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text("My Applications"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(
                        color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          )
        ],
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: appliedJobs,
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator());
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No Applications Yet"));
          }

          var jobs = snapshot.data!;

          return Column(
            children: [

              // 🔥 TOP CARD (Total Applications)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [

                    const Icon(Icons.work,
                        color: Colors.white, size: 40),

                    const SizedBox(width: 15),

                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Applied Jobs",
                          style: TextStyle(
                              color: Colors.white70),
                        ),
                        Text(
                          "${jobs.length}",
                          style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // 🔥 LIST
              Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {

                    var job = jobs[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: ListTile(

                          // 🔹 Icon
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor:
                            Colors.purple.shade100,
                            child: const Icon(
                              Icons.work,
                              color: Colors.purple,
                            ),
                          ),

                          // 🔹 Title + Company
                          title: Text(
                            job['title'],
                            style: const TextStyle(
                                fontWeight:
                                FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(job['company']),

                              Row(
                                children: [
                                  const Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color:
                                      Colors.purple),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(
                                      job['location'],
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ],
                              ),

                              const SizedBox(height: 5),

                              Row(
                                children: [
                                  Expanded(
                                      child: Text("₹${job['salary']} ${job['duration']}",
                                      overflow: TextOverflow.ellipsis,)),
                                ],
                              )
                            ],
                          ),

                          // 🔥 Applied badge
                          trailing: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check_circle,
                                  color: Colors.green),
                              Text("Applied",
                                  style: TextStyle(
                                      color:
                                      Colors.green)),
                            ],
                          ),

                          // 🔥 Click → detail page
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/job_details',
                              arguments: {
                                'job':Job.fromMap(job),
                                'user':widget.user,
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}