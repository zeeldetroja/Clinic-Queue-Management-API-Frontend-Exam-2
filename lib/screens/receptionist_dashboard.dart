import 'package:flutter/material.dart';

import 'login_screen.dart';

class ReceptionistDashboard extends StatefulWidget {
  const ReceptionistDashboard({super.key});

  @override
  State<ReceptionistDashboard> createState() => _ReceptionistDashboardState();
}

class _ReceptionistDashboardState extends State<ReceptionistDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receptionist Dashboard',
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: [
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Queue')),
              TextButton(onPressed: () {}, child: Text('TV display')),
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
      body: Center(child: Text('Receptionist Dashboard'),),
    );
  }
}
