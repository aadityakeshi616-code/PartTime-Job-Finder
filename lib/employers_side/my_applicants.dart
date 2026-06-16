import 'package:flutter/material.dart';
import '../db_helper.dart';

class MyApplicantsScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const MyApplicantsScreen({super.key, required this.user});

  @override
  State<MyApplicantsScreen> createState() => _MyApplicantsScreenState();
}

class _MyApplicantsScreenState extends State<MyApplicantsScreen> {

  late Future<List<Map<String, dynamic>>> applicants;

  @override
  void initState() {
    super.initState();
    applicants = DatabaseHelper.instance
        .getApplicants(widget.user['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Applicants"),
        backgroundColor: Colors.purple,
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: applicants,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Applicants Yet"));
          }

          var data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {

              var item = data[index];

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ListTile(

                  leading: const CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.person, color: Colors.white),
                  ),

                  title: Text(item['name']),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['email']),
                      Text(item['mobile']),
                      const SizedBox(height: 5),
                      Text("Applied for: ${item['title']}"),
                      Text(item['location']),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
