import 'package:earnmate/register.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  bool isPasswordVisible = false; // 👁️ NEW

  void login() async {
    if (_formKey.currentState!.validate()) {

      var user = await dbHelper.loginUser(
        emailController.text,
        passwordController.text,
      );

      if (user != null) {
        String role = user['role'];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful ($role)")),
        );

        if(role == 'student'){
          Navigator.pushNamedAndRemoveUntil(context, '/student',
              (route) => false,
              arguments: user);
        }
        else{
          Navigator.pushNamedAndRemoveUntil(context, '/employer',
              (route) => false,
              arguments: user);
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid Credentials")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        // 🔥 Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // 🔥 Title
                      const Icon(Icons.work, size: 50, color: Colors.purple),

                      const SizedBox(height: 10),

                      const Text(
                        "EARNMATE",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Login to continue",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 20),

                      // 📧 Email Field
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Enter Email";
                          if (!value.contains('@')) return "Invalid Email";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // 🔐 Password Field + 👁️
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Enter Password";
                          if (value.length < 4) return "Min 4 characters";
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // 🔥 Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: login,
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 🔹 Register
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterScreen()));
                        },
                        child: const Text("Create Account"),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}