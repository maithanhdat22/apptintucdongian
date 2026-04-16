import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'data/ repositories/news_repository_impl.dart';
import 'data/datasources/news_remote_data_source.dart';
import 'domain/usecases/get_articles.dart';
import ' presentation/providers/news_provider.dart';
import ' presentation/screens/home_screen.dart';

void main() {
  final remoteDataSource = NewsRemoteDataSource(http.Client());
  final repository = NewsRepositoryImpl(remoteDataSource);
  final getArticles = GetArticles(repository);

  runApp(MyApp(getArticles: getArticles));
}

class MyApp extends StatelessWidget {
  final GetArticles getArticles;

  const MyApp({super.key, required this.getArticles});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider(getArticles: getArticles),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        home: const HomeScreen(),
      ),
    );
  }
}