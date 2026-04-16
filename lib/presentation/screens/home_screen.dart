import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';
import 'article_detail_screen.dart';
import 'favorites_screen.dart';
import 'about_screen.dart';
import '../widgets/article_card.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NewsProvider>().fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== MENU =====
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.indigo,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.newspaper,
                        size: 50, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'News App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Quản lý tin tức cá nhân',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              // Trang chủ
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Trang chủ'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              // Yêu thích
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Yêu thích'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FavoritesScreen(),
                    ),
                  );
                },
              ),

              // About
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Giới thiệu'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // ===== APPBAR =====
      appBar: AppBar(
        title: const Text('News App'),
      ),

      // ===== BODY =====
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingView();
          }

          if (provider.errorMessage != null) {
            return ErrorView(
              message: provider.errorMessage!,
              onRetry: provider.fetchArticles,
            );
          }

          if (provider.articles.isEmpty) {
            return const EmptyView(
              message: 'Không có bài viết nào',
            );
          }

          final articles = provider.filteredArticles;

          return Column(
            children: [
              // SEARCH
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm theo tiêu đề...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: provider.searchArticles,
                ),
              ),

              // LIST
              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.refreshArticles,
                  child: articles.isEmpty
                      ? const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 500,
                      child: EmptyView(
                        message: 'Không tìm thấy bài viết',
                      ),
                    ),
                  )
                      : ListView.builder(
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];

                      return ArticleCard(
                        article: article,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ArticleDetailScreen(
                                      article: article),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}