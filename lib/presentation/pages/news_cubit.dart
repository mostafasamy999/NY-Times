
import '../../core/error/error_handler.dart';
import '../../domain/repositories/article_repository.dart';
import '../../domain/usecases/get_articles.dart';
import 'news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewsCubit extends Cubit<NewsState> {
  final GetNewsUseCase getNewsUseCase;

  NewsCubit({required this.getNewsUseCase}) : super(NewsInitial());

  Future<void> fetchNews() async {
    try {
      emit(NewsLoading());
      final articles = await getNewsUseCase();
      if (articles.isEmpty) {
        emit(NewsEmpty('No articles found'));
      } else {
        emit(NewsLoaded(articles));
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getMessage(e);
      emit(NewsError(errorMessage));
    }
  }

  void refresh() {
    fetchNews();
  }
}