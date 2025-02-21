import 'package:intl/intl.dart';

import '../../domain/entities/article.dart';
import 'article_model.dart';

extension ArticleMapper on Docs {
  Article toArticle() {
    final authorName = byline?.original ?? 'Unknown Author';
    final imageUrl = _extractImageUrl();
    final formattedDate = _formatDate();

    return Article(
      title: headline?.main ?? 'No Title',
      author: authorName,
      date: formattedDate,
      imageUrl: imageUrl,
      summary: abstract ?? snippet ?? 'No summary available',
    );
  }

  String _extractImageUrl() {
    if (multimedia == null || multimedia!.isEmpty) {
      return 'https://via.placeholder.com/400x300';
    }

    final xlargeImage = multimedia!.firstWhere(
          (element) => element.subtype == 'xlarge',
      orElse: () => multimedia!.first,
    );

    if (xlargeImage.url != null) {
      return 'https://static01.nyt.com/${xlargeImage.url}';
    }

    return 'https://via.placeholder.com/400x300';
  }

  String _formatDate() {
    if (pubDate == null) return 'No date';

    try {
      final dateTime = DateTime.parse(pubDate!);
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}

extension NewsResponseMapper on NewsResponse {
  List<Article> toArticles() {
    return response?.docs?.map((doc) => doc.toArticle()).toList() ?? [];
  }
}