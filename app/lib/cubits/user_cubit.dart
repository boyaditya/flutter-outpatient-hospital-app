import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final int id;
  final String email;
  final String hashedPassword;

  UserModel({
    required this.id,
    required this.email,
    required this.hashedPassword,
  });

  static UserModel fromJson(Map<String, dynamic> item) {
    return UserModel(
      id: item['id'] ?? 0,
      email: item['email'] ?? '',
      hashedPassword: item['hashed_password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'hashed_password': hashedPassword,
    };
  }
}

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'hashed_password': password,
      }),
    );

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(json.decode(response.body));
      emit(user);

      // Parse the response body
      Map<String, dynamic> responseBody = json.decode(response.body);

      // Store the access token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'access_token', responseBody['access_token'].toString());

      // Store the user's id
      await prefs.setInt('user_id', user.id);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('user_id');
    emit(null);
  }

  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'email': email,
          'hashed_password': password,
        },
      ),
    );

    if (response.statusCode == 201) {
      UserModel user = UserModel.fromJson(json.decode(response.body));

      // Store the user's id
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', user.id);

      emit(user);

      // print(response.body);
    } else if (response.statusCode == 400) {
      // Handle the error when the email is already registered
      throw Exception('Email already registered');
    }
  }
}
