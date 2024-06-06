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

  void setFromJson(List<dynamic> json) {
    List<DoctorScheduleModel> doctorSchedules =
        json.map((item) => DoctorScheduleModel.fromJson(item)).toList();

    emit(doctorSchedules);
  }

    final Map<int, DoctorScheduleModel> _doctorScheduleCache = {};

  Future<List<DoctorScheduleModel>> fetchDoctorScheduleByDoctorId(
      int doctorId) async {
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

  Future<void> fetchDoctorSchedule() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/doctor_schedules/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        List<DoctorScheduleModel> doctorSchedules =
            body.map((item) => DoctorScheduleModel.fromJson(item)).toList();

        for (var doctorSchedule in doctorSchedules) {
          _doctorScheduleCache[doctorSchedule.id] = doctorSchedule;
        }

        setFromJson(body);

        
      } else if (response.statusCode == 404) {
        emit([]);
      } else {
        throw Exception(
            'Failed to fetch doctor schedule: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctor schedule: $e');
    }
  }

  List<DoctorScheduleModel> getDoctorScheduleByDoctorId(int doctorId) {
    return _doctorScheduleCache.values.where((schedule) => schedule.doctorId == doctorId).toList();
  }
}
