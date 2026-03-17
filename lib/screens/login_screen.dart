import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_exam_2/core/api_client.dart';
import 'package:frontend_exam_2/core/api_const.dart';
import 'package:frontend_exam_2/screens/admin_dashboard.dart';
import 'package:frontend_exam_2/screens/doctor_dashboard.dart';
import 'package:frontend_exam_2/screens/patient_dashboard.dart';
import 'package:frontend_exam_2/screens/receptionist_dashboard.dart';
import 'package:frontend_exam_2/services/jwt_token_service.dart';
import 'package:frontend_exam_2/services/sharedpreference_service.dart';
// import 'package:frontend_exam_2/services/auth_service.dart';
import 'package:http/http.dart' as http;

// import '../services/jwt_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ApiClient apiClient = ApiClient();
  // AuthService authService = AuthService();
  // SharedPrefService sharedPrefService = SharedPrefService();
  // JwtService jwtService = JwtService();

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    final email = emailController.text.toString();
    final password = passwordController.text.toString();
    http.Response response = await apiClient.post(loginEndPoint, {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> loginData = jsonDecode(response.body);
      await PreferenceService().saveToken(loginData['token']);
      String? userRole = await JwtTokenService.userRole();
      if (userRole != null) {
        if (userRole == 'admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return AdminDashboard();
              },
            ),
          );
        } else if (userRole == 'patient') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PatientDashboard();
              },
            ),
          );
        } else if (userRole == 'doctor') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return DoctorDashboard();
              },
            ),
          );
        } else if (userRole == 'receptionist') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ReceptionistDashboard();
              },
            ),
          );
        }
      }
      // print(loginData);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Text(
              'Login Failed',
              style: TextStyle(color: Colors.redAccent),
            ),
          );
        },
      );
      // throw Exception('Login Failed');
    }
  }

  @override
  void initState() {
    emailController.text = '23010101060@darshan.ac.in';
    passwordController.text = 'password123';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Email";
                  }
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 5) {
                    return "Please enter atleast 5 characters";
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: submit, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
