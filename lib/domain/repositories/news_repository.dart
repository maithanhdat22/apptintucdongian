import 'package:kiemtragiuaki/domain/entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getArticles();
}