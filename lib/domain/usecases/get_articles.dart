import '../repositories/article_repository.dart';
import '../entities/article.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.getPopularNews();
  }
}
