import 'package:flutter/material.dart';
import '../db_helper.dart';

class PostJobScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const PostJobScreen({super.key, required this.user});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final durationController = TextEditingController();
  final timingController = TextEditingController();
  final descController = TextEditingController();

  String jobType = "Part-time";

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  void postJob() async {
    if (_formKey.currentState!.validate()) {

      await dbHelper.insertJob({
        'title': titleController.text,
        'company': companyController.text,
        'location': locationController.text,
        'salary': salaryController.text,
        'type': jobType,
        'duration': durationController.text,
        'shift_timing': timingController.text,
        'description': descController.text,
        'employer_id': widget.user['id']
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Job Posted Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      titleController.clear();
      companyController.clear();
      locationController.clear();
      salaryController.clear();
      durationController.clear();
      descController.clear();
      timingController.clear();
    }
  }

  // 🔥 Common styled input field (NEW)
  InputDecoration inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.purple),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        title: const Text(
          "Post New Job",
          style: TextStyle(color: Colors.white),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/login",
                              (route) => false,
                        );
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔥 TOP CARD (NEW UI)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.purple],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.work, color: Colors.white, size: 40),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        "Post a Job\nFind the right candidates quickly",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 📌 BASIC INFO
              const Text("Basic Info", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              TextFormField(
                controller: titleController,
                decoration: inputStyle("Job Title", Icons.work),
                validator: (v) => v!.isEmpty ? "Enter title" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: companyController,
                decoration: inputStyle("Company Name", Icons.business),
                validator: (v) => v!.isEmpty ? "Enter company" : null,
              ),

              const SizedBox(height: 20),

              // 📌 LOCATION + SALARY
              const Text("Job Details", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              TextFormField(
                controller: locationController,
                decoration: inputStyle("Location", Icons.location_on),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: salaryController,
                decoration: inputStyle("Salary", Icons.currency_rupee),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField(
                value: jobType,
                items: const [
                  DropdownMenuItem(value: "Part-time", child: Text("Part-time")),
                  DropdownMenuItem(value: "Full-time", child: Text("Full-time")),
                ],
                onChanged: (value) {
                  setState(() {
                    jobType = value!;
                  });
                },
                decoration: inputStyle("Job Type", Icons.work_outline),
              ),

              const SizedBox(height: 20),

              // 📌 WORK INFO
              const Text("Work Info", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              TextFormField(
                controller: durationController,
                decoration: inputStyle("Duration", Icons.calendar_today),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: timingController,
                decoration: inputStyle("Shift Timing", Icons.access_time),
              ),

              const SizedBox(height: 20),

              // 📌 DESCRIPTION
              const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              TextFormField(
                controller: descController,
                maxLines: 4,
                decoration: inputStyle("Write job details...", Icons.description),
              ),

              const SizedBox(height: 25),

              // 🔥 GRADIENT BUTTON (UPDATED)
              SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: postJob,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.purple],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Post Job",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}