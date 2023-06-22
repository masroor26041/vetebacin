import 'dart:async';
import 'dart:convert';

import 'package:sql_conn/sql_conn.dart';

import 'package:http/http.dart' as http;


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

   factory DatabaseHelper() => _instance;

   static late SqlConn _connection;

   DatabaseHelper._internal();

  Future<http.Response> register(String lastname,String name, String email,String city,String birthdate,String satus, String password) async {
    const url = 'https://gptkosovo.azurewebsites.net/api/register?code=rvobKmD6f60bEjJfQSqMPiMFCc-KMPdrRPEwam9Z_NDqAzFuTCey0w==';

    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'};

    final body = jsonEncode({
      'lastname': lastname,
      'name': name,
      'email': email,
      'city': city,
      'birthdate': birthdate,
      'satus': satus,
      'password': password,
    });

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      // Registration successful
      print('Registration successful');
    } else {
      // Registration failed
      print('Registration failed with error code ${response.statusCode}');
    }

    return response;
  }





  Future<bool> login(String email, String password) async {
    const url =
        'https://gptkosovo.azurewebsites.net/api/login?code=rvobKmD6f60bEjJfQSqMPiMFCc-KMPdrRPEwam9Z_NDqAzFuTCey0w==';

    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(Uri.parse(url), headers: headers, body: body);


    print(response.statusCode);


    if (response.statusCode == 200) {
      // Login successful
      print('Login successful');
      return true;
    } else {
      // Login failed
      print('Login failed with error code ${response.statusCode}');
      return false;
    }

  }


  Future<bool> resetPassword(String email,String birthday, String password) async {
    const url =
        'https://gptkosovo.azurewebsites.net/api/PasswordReset';

    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    print(email);
    print(birthday);
    print(password);
    final body = jsonEncode({
      'email': email,
      'birthdate': birthday,
      'new_password': password,
    });

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      // Login successful
      print('Reset password successful');
      return true;
    } else {
      // Login failed
      print('Reset password failed with error code ${response.statusCode}');
      return false;
    }

  }





}