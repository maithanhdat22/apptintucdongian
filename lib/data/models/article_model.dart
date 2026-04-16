import 'package:kiemtragiuaki/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required super.imageUrl,
    required super.publishedAt,
    super.isFavorite,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] ?? 0;
    final String title = json['title'] ?? '';
    final String body = json['body'] ?? '';

    return ArticleModel(
      id: id,
      title: title,
      description: body.length > 60 ? '${body.substring(0, 60)}...' : body,
      content: body,
      imageUrl: 'https://picsum.photos/seed/news$id/600/300',
      publishedAt: DateTime.now().subtract(Duration(days: id)),
      isFavorite: false,
    );
  }
}