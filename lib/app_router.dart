
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times/presentation/pages/detail_page/article_detail_screen.dart';

import 'package:ny_times/presentation/pages/home_list_page/news_listing_screen.dart';
import 'package:ny_times/presentation/pages/news_cubit.dart';

import 'di/injection_container.dart';
import 'domain/entities/article.dart';

class AppRouter {
  static const String home = '/';
  static const String articleDetail = '/article-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<NewsCubit>(),
            child: const NewsListingScreen(),
          ),
        );

      case articleDetail:
        final article = settings.arguments as Article;
        return MaterialPageRoute(
          builder: (_) => ArticleDetailScreen(article: article),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}