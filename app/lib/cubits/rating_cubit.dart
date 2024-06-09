import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RatingModel {
  final int id;
  int userId;
  final double rating;
  final String comment;
  final String category;

  RatingModel({
    required this.id,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.category,
  });

  static RatingModel fromJson(Map<String, dynamic> item) {
    return RatingModel(
      id: item['id'] ?? 0,
      userId: item['user_id'] ?? 0,
      rating: item['rating'] ?? 0.0,
      comment: item['comment'] ?? '',
      category: item['category'] ?? '',
    );
  }
}

class RatingCubit extends Cubit<List<RatingModel>> {
  RatingCubit() : super([]);

  Future<void> fetchRatings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    int? userId = prefs.getInt('user_id');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/ratings/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<RatingModel> ratings = responseBody.map((item) => RatingModel.fromJson(item)).toList();
      emit(ratings);
    } else {
      throw Exception('Failed to load ratings');
    }
  }

  Future<void> addRating(RatingModel rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    int? userId = prefs.getInt('user_id');

    rating.userId = userId!;

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/ratings/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'user_id': rating.userId,
        'rating': rating.rating,
        'comment': rating.comment,
        'category': rating.category,
      }),
    );

    if (response.statusCode == 200) {
      RatingModel newRating = RatingModel.fromJson(json.decode(response.body));
      List<RatingModel> updatedRatings = List.from(state)..add(newRating);
      emit(updatedRatings);
    } else {
      throw Exception('Failed to add rating');
    }
  }
}
