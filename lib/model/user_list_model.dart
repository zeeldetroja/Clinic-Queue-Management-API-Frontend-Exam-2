import 'dart:convert';

List<UserListModel> userListModelFromJson(String str) =>
    List<UserListModel>.from(
        json.decode(str).map((x) => UserListModel.fromJson(x)));

String userListModelToJson(List<UserListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {
  int? id;
  String? name;
  String? email;
  String? role;
  String? phone;
  String? createdAt;

  UserListModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      phone: json["phone"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role,
      "phone": phone,
      "createdAt": createdAt,
    };
  }
}