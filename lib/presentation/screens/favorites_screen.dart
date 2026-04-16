import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';
import 'article_detail_screen.dart';
import '../widgets/article_card.dart';
import '../widgets/empty_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin tức yêu thích'),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          final favorites = provider.favoriteArticles;

          if (favorites.isEmpty) {
            return const EmptyView(
              message: 'Chưa có bài viết yêu thích nào',
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final article = favorites[index];

              return ArticleCard(
                article: article,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}