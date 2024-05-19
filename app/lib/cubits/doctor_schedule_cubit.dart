import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorScheduleModel {
  final int id;
  final int doctorId;
  final String day;
  final String time;

  DoctorScheduleModel({
    required this.id,
    required this.doctorId,
    required this.day,
    required this.time,
  });

  static DoctorScheduleModel fromJson(Map<String, dynamic> item) {
    return DoctorScheduleModel(
      id: item['id'],
      doctorId: item['doctor_id'],
      day: item['day'],
      time: item['time'],
    );
  }
}

class DoctorScheduleCubit extends Cubit<List<DoctorScheduleModel>> {
  DoctorScheduleCubit() : super([]);

  Future<List<DoctorScheduleModel>> fetchDoctorSchedule(int doctorId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/doctor_schedules/$doctorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print("Doctor schedule fetched successfully");
        final data = jsonDecode(response.body);

        if (data == null) {
          throw Exception('No data returned from API');
        }

        return data
            .map<DoctorScheduleModel>(
                (item) => DoctorScheduleModel.fromJson(item))
            .toList();
      } else {
        throw Exception(
            'Failed to fetch doctor schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctor schedule: $e');
    }
  }
}
