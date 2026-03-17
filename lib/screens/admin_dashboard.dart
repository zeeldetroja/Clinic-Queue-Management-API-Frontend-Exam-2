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
  // bool info = false;
  List<UserListModel> userList = [];
  dynamic information;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> clinicInfo() async {
    // info = true;
    http.Response detail = await apiClient.get(
      clinicInformation,
      headers: {
        "Authorization": "Bearer ${await PreferenceService().getToken()}",
      },
    );

    print(detail.body);

    information = jsonDecode(detail.body);

    if (detail.statusCode == 200) {
      print(detail.body);
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
                  setState(() {});
                },
                child: Text('My Clinic'),
              ),
              TextButton(onPressed: () {}, child: Text('Users')),
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
      body: userList.isNotEmpty
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
