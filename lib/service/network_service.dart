import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model_home.dart';

class NetworkService {
  static Future<List<ModelHome>> fetchNews(String kategori) async {
    String baseUrl = 'https://pixabay.com/api/?key=12986876-82bf5b8a7f2948cd66ffd41f1&image_type=all&lang=id&category=$kategori';
    try {
      final response = await http.get(Uri.parse(baseUrl));
      List listData = (jsonDecode(response.body) as Map<String, dynamic>)['hits'];
      var dataNews = ModelHome.fromJsonList(listData);
      return dataNews;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}