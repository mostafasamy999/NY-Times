class ApiConstants {
  static const String baseUrl = 'https://api.nytimes.com/svc/search/v2/articlesearch.json';
  static const String apiKey = 'seK0AFEPwKbuArKaL0vYwuqAJFgRsAai';

  static String getArticlesUrl(String query, {int page = 0}) {
    return '$baseUrl?q=$query&fq=source:(%22The%20New%20York%20Times%22)&sort=newest&page=$page&api-key=$apiKey';
  }
}
