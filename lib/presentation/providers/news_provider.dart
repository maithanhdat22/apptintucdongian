import 'package:flutter/material.dart';
import 'package:kiemtragiuaki/domain/entities/article.dart';
import 'package:kiemtragiuaki/domain/usecases/get_articles.dart';

class NewsProvider extends ChangeNotifier {
  final GetArticles getArticles;

  NewsProvider({required this.getArticles});

  List<Article> _articles = [];
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Article> get filteredArticles {
    if (_searchQuery.isEmpty) return _articles;
    return _articles
        .where(
          (article) =>
          article.title.toLowerCase().contains(_searchQuery.toLowerCase()),
    )
        .toList();
  }

  List<Article> get favoriteArticles {
    return _articles.where((article) => article.isFavorite).toList();
  }

  Future<void> fetchArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await getArticles();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshArticles() async {
    await fetchArticles();
  }

  void searchArticles(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(int articleId) {
    _articles = _articles.map((article) {
      if (article.id == articleId) {
        return article.copyWith(isFavorite: !article.isFavorite);
      }
      return article;
    }).toList();
    notifyListeners();
  }

  bool isFavorite(int articleId) {
    return _articles.any(
          (article) => article.id == articleId && article.isFavorite,
    );
  }
}