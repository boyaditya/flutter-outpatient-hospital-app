import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentModel {
  final int id;
  final int doctorId;
  final int patientId;
  final String date;
  final String time;
  final String coverageType;
  final String status;
  final String timestamp;
  final int queueNumber;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.time,
    required this.coverageType,
    required this.status,
    required this.timestamp,
    required this.queueNumber,
  });

  static AppointmentModel fromJson(Map<String, dynamic> item) {
    return AppointmentModel(
      id: item['id'],
      doctorId: item['doctor_id'],
      patientId: item['patient_id'],
      date: item['date'],
      time: item['time'],
      coverageType: item['coverage_type'],
      status: item['status'],
      timestamp: item['timestamp'],
      queueNumber: item['queue_number'],
    );
  }
}

class AppointmentCubit extends Cubit<List<AppointmentModel>> {
  AppointmentCubit()
      : super([
          AppointmentModel(
            id: 0,
            doctorId: 0,
            patientId: 0,
            date: '',
            time: '',
            coverageType: '',
            status: '',
            timestamp: '',
            queueNumber: 0,
          )
        ]);

  void setFromJson(List<dynamic> json) {
    List<AppointmentModel> appointments =
        json.map((item) => AppointmentModel.fromJson(item)).toList();

    _appointmentCache = appointments;
    emit(appointments);
  }

  List<AppointmentModel> _appointmentCache = [];

  Future<int> postAppointment(AppointmentModel appointment) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/appointments/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'doctor_id': appointment.doctorId,
          'patient_id': appointment.patientId,
          'date': appointment.date,
          'time': appointment.time,
          'coverage_type': appointment.coverageType,
          'status': appointment.status,
          'queue_number': appointment.queueNumber,
        }),
      );

      if (response.statusCode == 201) {
        AppointmentModel appointment =
            AppointmentModel.fromJson(json.decode(response.body));
        emit([...state, appointment]);
        return appointment.id;

        // print(response.body);
      } else {
        throw Exception('Failed to post appointment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post appointment: $e');
    }
  }

  Future<void> fetchAppointmentsByPatientId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      int? patientId = prefs.getInt('patient_id');
      print(patientId);

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/appointments/patient/$patientId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = json.decode(response.body);
        setFromJson(responseBody);
      } else {
        if (response.statusCode == 404) {
          emit([]);
          print('No appointments found');
        } else {
          throw Exception(
              'Failed to load appointmentszz: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Failed to load appointments: $e');
    }
  }

  AppointmentModel getAppointmentById(int id) {
    return _appointmentCache[id];
  }

  int getAppointmentByStatus() {
    return _appointmentCache
        .lastWhere((element) => element.status == "Scheduled")
        .id;
  }
}
