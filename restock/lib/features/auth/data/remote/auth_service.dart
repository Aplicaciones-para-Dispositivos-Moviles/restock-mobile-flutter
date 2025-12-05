import 'dart:convert';
import 'dart:io';
import 'package:restock/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // LOGIN -------------------------
  Future<String> login(String username, String password) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
      );

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.body);
        return data['token'];  
      }

      throw HttpException('Unexpected HTTP Status: ${response.statusCode}');
    } on SocketException {
      throw const SocketException('Failed to establish network connection');
    }
  }

  // REGISTER ----------------------
  Future<void> register({
    required String username,
    required String password,
    required int roleId,
  }) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}',
      );

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'roleId': roleId,
        }),
      );

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return;
      }

      throw HttpException('Unexpected HTTP Status: ${response.statusCode}');
    } on SocketException {
      throw const SocketException('Failed to establish network connection');
    }
  }
}
