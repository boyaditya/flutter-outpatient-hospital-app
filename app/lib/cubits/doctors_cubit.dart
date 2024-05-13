import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubes/cubits/specialization_state.dart';

class DoctorModel {
  final int id;
  final String name;
  final String imgName;
  final String interest;
  final String education;
  final int idSpecialization;
  // final SpecializationModel specialization;

  DoctorModel({
    required this.id,
    required this.name,
    required this.imgName,
    required this.interest,
    required this.education,
    required this.idSpecialization,
    // required this.specialization,
  });

  static DoctorModel fromJson(Map<String, dynamic> item) {
    return DoctorModel(
      id: item['id'],
      name: item['name'],
      imgName: item['img_name'],
      interest: item['interest'],
      education: item['education'],
      idSpecialization: item['id_specialization'],
      // specialization: SpecializationModel.fromJson(item['specialization']),
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
            interest: "",
            education: "",
            idSpecialization: 0,
            // specialization: SpecializationModel(
            //   id: 0,
            //   title: "",
            //   description: "",
            //   imgName: "",
            // ),
          )
        ]);

  // void setFromJson(List<dynamic> json) {
  //   List<DoctorModel> doctors = json
  //       .map((item) => DoctorModel(
  //             id: item['id'],
  //             name: item['name'],
  //             imgName: item['img_name'],
  //             interest: item['interest'],
  //             education: item['education'],
  //             idSpecialization: item['id_specialization'],
  //             // specialization: SpecializationModel(
  //             //   id: item['specialization']['id'],
  //             //   title: item['specialization']['title'],
  //             //   description: item['specialization']['description'],
  //             //   imgName: item['specialization']['img_name'],
  //             // ),
  //           ))
  //       .toList();
  //   print('Current state: ${doctors[0].name}');
  //   emit(doctors);
  // }

  void setFromJson(List<dynamic> json) {
    List<DoctorModel> doctors =
        json.map((item) => DoctorModel.fromJson(item)).toList();
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
