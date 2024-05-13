import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

// class SpecializationListCubit extends Cubit<List<SpecializationModel>> {
//   SpecializationListCubit()
//       : super([
//           SpecializationModel(
//             id: 0,
//             title: "",
//             description: "",
//             imgName: "",
//           )
//         ]);

//   void setFromJson(List<dynamic> json) {
//     List<SpecializationModel> specializations =
//         json.map((item) => SpecializationModel.fromJson(item)).toList();
//     emit(specializations);
//   }

//   void fetchSpecializations() async {
//     final response =
//         await http.get(Uri.parse('http://127.0.0.1:8000/specializations/'));
//     final json = jsonDecode(response.body);
//     setFromJson(json);
//   }
// }

class SpecializationListCubit extends Cubit<Map<int, SpecializationModel>> {
  SpecializationListCubit() : super({});

  Future<void> fetchSpecializations() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/specializations/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      Map<int, SpecializationModel> specializations = {};
      for (var item in jsonResponse) {
        SpecializationModel specialization = SpecializationModel.fromJson(item);
        specializations[specialization.id] = specialization;
      }
      emit(specializations);
    } else {
      throw Exception('Failed to load specializations');
    }
  }
}
