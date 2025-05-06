import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_front/api_path.dart';

class UserServices {
  static Future<http.Response> SignUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    final response = await http.post(
      Uri.parse(ApiPath.signUp),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'userName': userName,
      }),
    );
    return response;
  }

  static Future<http.Response> deleteUser(int id) async {
  final url = Uri.parse(ApiPath.delete + id.toString());
  print("DELETE URL: $url"); // Add this
  return await http.delete(url);
}

static Future<http.Response> updateUser({
  required int id,
  required String userName,
  required String email,
}) async {
  final url = Uri.parse(ApiPath.update + id.toString());
  print("UPDATE URL: $url"); // Add this

  final body = jsonEncode({
    'userName': userName,
    'email': email,
  });

  return await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: body,
  );
}

}
