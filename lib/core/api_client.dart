import 'dart:convert';

import 'package:frontend_exam_2/core/api_const.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "https://cmsback.sampaarsh.cloud";

  Future<http.Response> post(String endPoint, Map<String, dynamic> body) async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl$endPoint'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
    // print(response.body);
  }

  Future<http.Response> get(
    String endPoint, {
    Map<String, String>? headers,
  }) async {
    return await http.get(Uri.parse('$baseUrl$endPoint'), headers: headers!);
  }
}
