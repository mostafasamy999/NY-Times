
import 'dart:convert';

import 'package:ny_times/domain/repositories/article_repository.dart';
import '../../core/error/exceptions.dart';

import '../../domain/entities/article.dart';
import '../datasources/article_remote_data_source.dart';
import '../models/DocToArticleMapper.dart';
import '../models/article_model.dart';




class NewsRepositoryImpl extends NewsRepository{
  final ApiService apiService;
  NewsRepositoryImpl({required this.apiService});
  @override
  Future<List<Article>> getPopularNews() async {
    try {
      final data = await apiService.getNews();

      return data.toArticles();

    } on NetworkException catch (e) {
      throw NetworkException('Unable to fetch news: ${e.message}');
    } on ServerException catch (e) {
      throw ServerException('Server error: ${e.message}');
    } on ApiException catch (e) {
      throw ApiException('API error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}