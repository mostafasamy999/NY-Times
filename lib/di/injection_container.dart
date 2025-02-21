import 'package:get_it/get_it.dart';
import 'package:ny_times/data/repositories/article_repository_impl.dart';
import '../data/datasources/article_remote_data_source.dart';
import '../domain/repositories/article_repository.dart';
import '../domain/usecases/get_articles.dart';

import '../presentation/pages/news_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    //  Services
    getIt.registerLazySingleton<ApiService>(() => ApiService());

    //  Repositories
    getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
      apiService: getIt<ApiService>(),
    ));

    //  Use Cases
    getIt.registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(getIt<NewsRepository>()));

    //  Cubits
    getIt.registerFactory<NewsCubit>(() => NewsCubit(
      getNewsUseCase: getIt<GetNewsUseCase>(),
    ));
  }
}
