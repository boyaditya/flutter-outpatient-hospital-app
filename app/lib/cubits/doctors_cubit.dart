import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tubes/cubits/doctors_state.dart';

class DoctorListCubit extends Cubit<List<DoctorModel>> {
  DoctorListCubit()
      : super([
          DoctorModel(
            id: 0,
            name: "",
            imgName: "",
            interest: "",
            education: "",
            idSpecialization: 0,
          )
        ]);

  void setFromJson(List<dynamic> json) {
    List<DoctorModel> doctors = json
        .map((item) => DoctorModel(
              id: item['id'],
              name: item['name'],
              imgName: item['img_name'],
              interest: item['interest'],
              education: item['education'],
              idSpecialization: item['id_specialization'],
            ))
        .toList();
        print('Current state: ${doctors[0].name}');
    emit(doctors);
  }

  void fetchDoctors() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/doctors/'));
    final data = jsonDecode(response.body);
    setFromJson(data);
  }

  @override
  void onChange(Change<List<DoctorModel>> change) {
    print(change);
    super.onChange(change);
  }
}
