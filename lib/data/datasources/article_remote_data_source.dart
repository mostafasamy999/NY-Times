
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exceptions.dart';
import '../../core/network/api_constants.dart';
import '../models/article_model.dart';


class ApiService {
  Future<NewsResponse> getNews() async {//dynamic
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getArticlesUrl('election', page: 0)),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw NetworkTimeoutException('Request timed out'),
      );

      return _processResponse(response);
    } on http.ClientException {
      throw NetworkException('Network error occurred');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw UnexpectedException('Unexpected error: $e');
    }
  }

  NewsResponse _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData); // Convert JSON to NewsResponse
      case 401:
        throw UnauthorizedException('Authentication failed');
      case 403:
        throw ForbiddenException('You do not have access to this resource');
      case 404:
        throw NotFoundException('Resource not found');
      case 429:
        throw RateLimitedException('Too many requests, please try again later');
      case 500:
      case 502:
      case 503:
      case 504:
        throw ServerException('Server error occurred');
      default:
        throw ApiException('Request failed with status: ${response.statusCode}');
    }
  }
}