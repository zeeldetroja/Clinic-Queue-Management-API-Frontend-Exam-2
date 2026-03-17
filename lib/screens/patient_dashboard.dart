import 'package:flutter/material.dart';

import 'login_screen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Dashboard',
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: [
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Dashboard')),
              TextButton(onPressed: () {}, child: Text('Book Appointment')),
              TextButton(onPressed: () {}, child: Text('My Appointment')),
              TextButton(onPressed: () {}, child: Text('My prescription')),
              TextButton(onPressed: () {}, child: Text('My reports')),
              TextButton(onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false, );
              }, child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: Center(child: Text('Patient Dashboard'),),
    );
  }
}
