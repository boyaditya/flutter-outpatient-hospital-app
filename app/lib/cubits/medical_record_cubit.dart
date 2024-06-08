import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalRecordModel {
  final int id;
  final int appointmentId;
  final String complaint;
  final String diagnosis;
  final String treatment;
  final String notes;

  MedicalRecordModel({
    required this.id,
    required this.appointmentId,
    required this.complaint,
    required this.diagnosis,
    required this.treatment,
    required this.notes,
  });

  static MedicalRecordModel fromJson(Map<String, dynamic> item) {
    return MedicalRecordModel(
      id: item['id'],
      appointmentId: item['appointment_id'],
      complaint: item['complaint'],
      diagnosis: item['diagnosis'],
      treatment: item['treatment'],
      notes: item['notes'],
    );
  }
}

class MedicalRecordCubit extends Cubit<List<MedicalRecordModel>> {
  MedicalRecordCubit()
      : super([
          MedicalRecordModel(
            id: 0,
            appointmentId: 0,
            complaint: '',
            diagnosis: '',
            treatment: '',
            notes: '',
          )
        ]);

  void setFromJson(List<dynamic> json) {
    List<MedicalRecordModel> records =
        json.map((item) => MedicalRecordModel.fromJson(item)).toList();

    emit(records);
  }

  Future<int> postMedicalRecord(MedicalRecordModel record) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/medical_records/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'appointment_id': record.appointmentId,
          'complaint': record.complaint,
          'diagnosis': record.diagnosis,
          'treatment': record.treatment,
          'notes': record.notes,
        }),
      );

      if (response.statusCode == 201) {
        MedicalRecordModel record =
            MedicalRecordModel.fromJson(json.decode(response.body));
        emit([...state, record]);
        return record.id;
      } else {
        throw Exception('Failed to post medical record: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post medical record: $e');
    }
  }

  Future<void> fetchMedicalRecordsByUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      int? userId = prefs.getInt('user_id');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/medical_records/user/$userId'),
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
          print(' Medical records not found');
        } else {
          throw Exception(
              'Failed to load medical records: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Failed to load medical records: $e');
    }
  }

  MedicalRecordModel getMedicalRecordById(int id) {
    return state.firstWhere((record) => record.id == id);
  }
}