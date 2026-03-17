import 'package:flutter/material.dart';

import 'login_screen.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Dashboard',
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: [
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text("Today's Queue")),
              TextButton(onPressed: () {}, child: Text('Add Prescription')),
              TextButton(onPressed: () {}, child: Text('Add Report')),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(child: Text('Doctor Dashboard')),
    );
  }
}
