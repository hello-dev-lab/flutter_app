import 'dart:convert';
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);


List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    int? id;
    String? email;
    String? userName;
    String? createdAt;
    DateTime? updatedAt;

    UserModel({
        this.id,
        this.email,
        this.userName,
        this.createdAt,
        this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        userName: json["userName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "userName": userName,
        "createdAt": createdAt,
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
