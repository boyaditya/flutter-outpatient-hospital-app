// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorModel {
  final int id;
  final String name;
  final String imgName;
  final String imgPath;
  final String interest;
  final String education;
  final int idSpecialization;

  DoctorModel({
    required this.id,
    required this.name,
    required this.imgName,
    required this.imgPath,
    required this.interest,
    required this.education,
    required this.idSpecialization,
  });

  static DoctorModel fromJson(Map<String, dynamic> item) {
    return DoctorModel(
      id: item['id'],
      name: item['name'],
      imgName: item['img_name'],
      imgPath: item['img_path'] ?? '',
      interest: item['interest'],
      education: item['education'],
      idSpecialization: item['id_specialization'],
    );
  }
}

class DoctorListCubit extends Cubit<List<DoctorModel>> {
  DoctorListCubit()
      : super([
          DoctorModel(
            id: 0,
            name: "",
            imgName: "",
            imgPath: "",
            interest: "",
            education: "",
            idSpecialization: 0,
          )
        ]);

  void setFromJson(List<dynamic> json) {
    List<DoctorModel> doctors =
        json.map((item) => DoctorModel.fromJson(item)).toList();

    emit(doctors);
  }

  final Map<int, DoctorModel> _doctorCache = {};

  // Future<DoctorModel> fetchDoctorById(int id) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? accessToken = prefs.getString('access_token');

  //     if (accessToken == null) {
  //       throw Exception('No access token found');
  //     }

  //     final response = await http.get(
  //       Uri.parse('http://127.0.0.1:8000/doctors/$id'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return DoctorModel.fromJson(data);
  //     } else {
  //       throw Exception('Failed to fetch doctor: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to fetch doctor: $e');
  //   }
  // }

  Future<void> fetchDoctors() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/doctors/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Map<String, dynamic>> updatedData = [];
        for (var doctor in data) {
          final imageResponse = await http.get(
            Uri.parse('http://127.0.0.1:8000/doctors/image/${doctor['id']}'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          );
          if (imageResponse.statusCode == 200) {
            Map<String, dynamic> updatedDoctor = Map.from(doctor);
            updatedDoctor['img_path'] =
                'http://127.0.0.1:8000/doctors/image/${doctor['id']}';
            // print(updatedDoctor['img_path']);
            updatedData.add(updatedDoctor);
            _doctorCache[doctor['id']] = DoctorModel.fromJson(updatedDoctor);
          } else {
            throw Exception('Failed to load image from API');
          }
        }
        setFromJson(updatedData);
      } else {
        print('Failed to fetch doctors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  DoctorModel getDoctorById(int id) {
    return _doctorCache[id]!;
  }

  // @override
  // void onChange(Change<List<DoctorModel>> change) {
  //   print(change);
  //   super.onChange(change);
  // }
}



