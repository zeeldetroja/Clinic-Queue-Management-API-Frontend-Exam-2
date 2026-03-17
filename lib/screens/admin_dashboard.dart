import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_exam_2/core/api_client.dart';
import 'package:frontend_exam_2/core/api_const.dart';
import 'package:frontend_exam_2/model/user_list_model.dart';
import 'package:frontend_exam_2/services/sharedpreference_service.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  ApiClient apiClient = ApiClient();
  bool info = false;
  List<UserListModel> userList = [];
  Map<String, dynamic> information = {};
  // dynamic information;

  @override
  void initState() {
    super.initState();
    getUsers();
    // clinicInfo();
  }

  Future<void> clinicInfo() async {
    // info = true;
    http.Response res = await apiClient.get(
      clinicInformation,
      headers: {
        "Authorization": "Bearer ${await PreferenceService().getToken()}",
      },
    );

    print("Deatila-----------${jsonDecode(res.body)}");

    if (res.statusCode == 200) {
      information = jsonDecode(res.body);
    } else {
      print("Failed to load information");
    }
  }

  Future<void> getUsers() async {
    http.Response response = await apiClient.get(
      getAllUsers,
      headers: {
        "Authorization": "Bearer ${await PreferenceService().getToken()}",
      },
    );

    // print(response.body);

    if (response.statusCode == 200) {
      userList = userListModelFromJson(response.body);
      setState(() {});
    } else {
      print("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  await clinicInfo();
                  setState(() {
                    info = true;
                  });
                },
                child: Text('My Clinic'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    info = false;
                  });
                },
                child: Text('Users'),
              ),
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
      body: info
          ? Column(
            children: [
              ListTile(
                  title: Text('Name :${information['name']}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Code : ${information['code']}'),
                      Text('User Count =${information['userCount']}'),
                      Text('Appointment Count =${information['appointmentCount']}'),
                      Text('Queue Count =${information['queueCount']}'),
                    ],
                  ),
                ),
            ],
          )
          : userList.isNotEmpty
          ? ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];

                return Card(
                  child: ListTile(
                    title: Text(user.name ?? ""),
                    subtitle: Text(user.role ?? ""),
                    trailing: Text(user.email ?? ""),
                  ),
                );
              },
            )
          : Center(child: Text("No User Found")),
    );
  }
}
