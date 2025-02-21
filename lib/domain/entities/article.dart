
class Article {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String summary;

  Article({
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.summary,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String authorName = '';
    if (json['byline'] != null && json['byline']['original'] != null) {
      authorName = json['byline']['original'];
    }

    String imageUrl = '';
    if (json['multimedia'] != null && (json['multimedia'] as List).isNotEmpty) {
      var multimedia = json['multimedia'] as List;
      var largeImage = multimedia.firstWhere(
            (element) => element['subtype'] == 'xlarge',
        orElse: () => multimedia.first,
      );
      if (largeImage != null && largeImage['url'] != null) {
        imageUrl = 'https://static01.nyt.com/${largeImage['url']}';
      }
    }

    return Article(
      title: json['headline']?['main'] ?? '',
      author: authorName,
      date: json['pub_date'] ?? '',
      imageUrl: imageUrl,
      summary: json['abstract'] ?? json['snippet'] ?? '',
    );
  }
}
