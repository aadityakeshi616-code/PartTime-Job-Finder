import 'package:flutter/material.dart';
import 'db_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  String selectRole = 'student';

  bool isPasswordVisible = false; // 👁️ NEW

  void register() async {
    if (_formKey.currentState!.validate()) {

      await dbHelper.registerUser({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'role': selectRole,
        'mobile': mobileController.text
      });

      print("data inserted");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registered Successfully")),
      );
      //yahaaa seee

      var user = await dbHelper.loginUser(
        emailController.text,
        passwordController.text,
      );

      await Future.delayed(const Duration(milliseconds: 800));
      if(user!=null){
        if(user['role'] == 'student'){
          Navigator.pushNamedAndRemoveUntil(context,
              '/student',
              (route) => false,
            arguments: user,
          );
        } else{
          Navigator.pushNamedAndRemoveUntil(context,
              '/employer',
              (route)=> false,
            arguments: user,
          );
        }
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        // 🎨 Gradient Background
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

                      const Icon(Icons.person_add,
                          size: 50, color: Colors.purple),

                      const SizedBox(height: 10),

                      const Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 20),

                      // 👤 Name
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Enter Name";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // 📧 Email
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

                      // Mobile No
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          prefixIcon: const Icon(Icons.phone),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        validator: (value){
                          if(value!.isEmpty) return "Enter Mobile Number";
                          if(value.length<10) return "Invalid Mobile Number";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15,),

                      // 🔐 Password + 👁️
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

                      const SizedBox(height: 15),

                      // 🎭 Role Dropdown (Radio removed 🔥)
                      DropdownButtonFormField<String>(
                        value: selectRole,
                        items: const [
                          DropdownMenuItem(
                              value: "student",
                              child: Text("Student")),
                          DropdownMenuItem(
                              value: "employer",
                              child: Text("Employer")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectRole = value!;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔥 Register Button
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
                          onPressed: register,
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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