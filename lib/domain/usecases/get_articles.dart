import 'package:kiemtragiuaki/domain/entities/article.dart';
import 'package:kiemtragiuaki/domain/repositories/news_repository.dart';

class GetArticles {
  final NewsRepository repository;

  GetArticles(this.repository);

  Future<List<Article>> call() async {
    return await repository.getArticles();
  }
}