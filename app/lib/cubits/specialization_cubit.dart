// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SpecializationModel {
  final int id;
  final String title;
  final String description;
  final String imgName;

  SpecializationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgName,
  });

  static SpecializationModel fromJson(Map<String, dynamic> item) {
    return SpecializationModel(
      id: item['id'],
      title: item['title'],
      description: item['description'],
      imgName: item['img_name'],
    );
  }
}

class SpecializationListCubit extends Cubit<List<SpecializationModel>> {
  SpecializationListCubit()
      : super([
          SpecializationModel(
            id: 0,
            title: "",
            description: "",
            imgName: "",
          )
        ]);

  void setFromJson(List<dynamic> json) {
    List<SpecializationModel> specializations =
        json.map((item) => SpecializationModel.fromJson(item)).toList();

    emit(specializations);
  }

  final Map<int, SpecializationModel> _specializationCache = {};

  Future<void> fetchSpecializations() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/specializations/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Map<String, dynamic>> updatedData = [];
        for (var specialization in data) {
          final imageResponse = await http.get(
            Uri.parse('http://127.0.0.1:8000/specializations/image/${specialization['id']}'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          );
          if (imageResponse.statusCode == 200) {
            Map<String, dynamic> updatedSpecialization = Map.from(specialization);
            updatedSpecialization['img_name'] =
                'http://127.0.0.1:8000/specializations/image/${specialization['id']}';
            updatedData.add(updatedSpecialization);
            _specializationCache[specialization['id']] = SpecializationModel.fromJson(updatedSpecialization);
          } else {
            throw Exception('Failed to load image from API');
          }
        }
        setFromJson(updatedData);
      } else {
        print('Failed to fetch specializations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch specializations: $e');
    }
  }

  SpecializationModel? getSpecializationById(int id) {
    return _specializationCache[id];
  }
}