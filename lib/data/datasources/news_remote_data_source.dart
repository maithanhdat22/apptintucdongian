import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kiemtragiuaki/data/models/article_model.dart';

class NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSource(this.client);

  Future<List<ArticleModel>> fetchArticles() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List<dynamic>;
      return data
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Lỗi API: ${response.statusCode}');
    }
  }
}