import 'package:earnmate/employers_side/emp_dashboard.dart';
import 'package:earnmate/employers_side/job_post_screen.dart';
import 'package:earnmate/students_side/job_model.dart';
import 'package:earnmate/students_side/myapplications.dart';
import 'package:earnmate/students_side/stu_dashboard.dart';
import 'package:earnmate/login.dart';
import 'package:earnmate/register.dart';
import 'package:earnmate/splash/splash.dart';
import 'package:earnmate/students_side/stu_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../students_side/job_details.dart';
import '../students_side/stu_dashboard.dart';

class AppRoute{
  static Route<dynamic> onGenerateRoute(RouteSettings files){

    switch(files.name){
      case "/login": return MaterialPageRoute(builder: (_) => const LoginScreen());
      case "/register": return MaterialPageRoute(builder: (_)=> const RegisterScreen());
      case "/student":
        final user = files.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => StudentHome(user: user,));
      case "/employer":
        final user = files.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => EmpDashboard(user:user));


      case "/splash": return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case "/myapplication":
        final user = files.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => MyApplicationsScreen(user: user));


      case "/job_details":
        final data = files.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => JobDetailScreen(
            job: data['job'],
            user: data['user'],// 👈 FIX
          ),
        );

      case "post_job":
        final user = files.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => PostJobScreen(user: user));

      default: return MaterialPageRoute(builder: (_) => const Text("Page Not Found"));
    }
  }
}