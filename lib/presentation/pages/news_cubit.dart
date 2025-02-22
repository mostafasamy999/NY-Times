import '../../core/error/error_handler.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_articles.dart';
import 'news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsUseCase getNewsUseCase;
  NewsCubit({required this.getNewsUseCase}) : super(NewsInitial()) {
    fetchNews();
  }
  Future<void> fetchNews() async {
    emit(NewsLoading());
    try {
      final articles = await getNewsUseCase();
      if (articles.isEmpty) {
        emit(NewsEmpty('No articles found'));
      } else {
        if (state is NewsLoaded) {
          final currentState = state as NewsLoaded;
          emit(NewsLoaded(
            articles,
            searchQuery: currentState.searchQuery,
            filteredArticles:
                _filterArticles(articles, currentState.searchQuery),
          ));
        } else {
          emit(NewsLoaded(articles, filteredArticles: articles));
        }
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getMessage(e);
      emit(NewsError(errorMessage));
    }
  }

  void searchArticles(String query) {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final filteredArticles = _filterArticles(currentState.articles, query);
      emit(NewsLoaded(
        currentState.articles,
        searchQuery: query,
        filteredArticles: filteredArticles,
      ));
    }
  }

  List<Article> _filterArticles(List<Article> articles, String query) {
    if (query.isEmpty) return articles;
    return articles
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()) ||
            article.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void clearSearch() {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      emit(NewsLoaded(
        currentState.articles,
        searchQuery: '',
        filteredArticles: currentState.articles,
      ));
    }
  }

  void refresh() {
    fetchNews();
  }
}
