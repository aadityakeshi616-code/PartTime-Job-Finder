import 'package:earnmate/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:earnmate/routes/routes.dart';

void main(){
  runApp(const ProjectApp());
}

class ProjectApp extends StatelessWidget {
  const ProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EarnMate Project',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}

