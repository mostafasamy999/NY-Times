import '../../domain/entities/article.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsEmpty extends NewsState {
  final String message;
  NewsEmpty(this.message);
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final List<Article> filteredArticles;
  final String searchQuery;

  NewsLoaded(
      this.articles, {
        required this.filteredArticles,
        this.searchQuery = '',
      });
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}