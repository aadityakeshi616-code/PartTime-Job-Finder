import 'package:flutter/material.dart';
import '../db_helper.dart';
import 'job_model.dart';

class JobDetailScreen extends StatefulWidget {
  final Job job;
  final Map<String, dynamic> user;

  const JobDetailScreen({super.key, required this.job, required this.user});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {

  bool isApplied = false; // 🔥 state variable

  @override
  void initState() {
    super.initState();
    checkIfApplied();
  }

  void checkIfApplied() async{
    int userId = widget.user['id'];
    int jobId = widget.job.id!;

    bool already = await DatabaseHelper.instance.alreadyApplied(userId, jobId);
    setState(() {
      isApplied = already;
    });

  }



  @override
  Widget build(BuildContext context) {

    final job = widget.job; // 👈 access like this

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Job Details",style: TextStyle(color: Colors.white),),
      ),

      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  // 🔹 Top Card
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [

                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purple,
                            child: Icon(Icons.work,
                                color: Colors.white, size: 30),
                          ),

                          const SizedBox(width: 15),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                job.company,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.purple),
                                  const SizedBox(width: 5),
                                  Text(job.location),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Info Card
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          infoRow(Icons.location_on, "Location", job.location),
                          const Divider(),

                          infoRow(Icons.currency_rupee, "Salary", job.salary),
                          const Divider(),

                          infoRow(Icons.access_time, "Duration", job.duration),
                          const Divider(),

                          infoRow(Icons.work_outline, "Job Type",
                              job.type ?? "Part Time"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Description
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Job Description",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            job.description,
                            style:
                            TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔥 Apply Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,


            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isApplied ? Colors.grey : Colors.purple,
                padding:
                const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10)),
              ),
              onPressed: isApplied
                  ? null
                  : () async {

                int userId = widget.user['id'];
                int jobId = widget.job.id!;// 🔥 REAL USER

                bool already = await DatabaseHelper.instance
                    .alreadyApplied(userId, jobId);

                if (already) {
                  setState(() {
                    isApplied = true;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Already Applied")),
                  );
                } else {

                  await DatabaseHelper.instance.applyJob(
                    userId,
                    jobId,
                  );

                  setState(() {
                    isApplied = true; // 🔥 UI update
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Applied Successfully")),
                  );
                }
              },
              icon: const Icon(Icons.send,color: Colors.white,),
              label: Text(isApplied ? "Applied" : "Apply Now", style: TextStyle(color: Colors.white), ),
            ),
          )
        ],
      ),
    );
  }

  // 🔧 reusable row
  Widget infoRow(IconData icon, String title, dynamic value) {
    return Row(
      children: [
        Icon(icon, color: Colors.purple),
        const SizedBox(width: 10),
        Text(
          "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value.toString())),
      ],
    );
  }
}