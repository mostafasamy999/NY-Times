
import 'package:flutter/material.dart';
import '../../../../domain/entities/article.dart';


class ArticleListItem extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleListItem({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArticleImage(),
            const SizedBox(width: 12),
            _buildArticleTextContent(),
            const Icon(Icons.chevron_right, size:32,color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleImage() {
    return ClipOval(
      child: article.imageUrl.isNotEmpty
          ? Image.network(
        article.imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
      )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey[300],
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  Widget _buildArticleTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(),
          const SizedBox(height: 4),
          _buildAuthorText(),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, size: 14),
                const SizedBox(width: 4),
                _buildDateText(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      article.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAuthorText() {
    return Text(
      'By ${article.author}',
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 12,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateText() {
    return Text(
      article.date,
      style: TextStyle(
        color: Colors.grey[500],
        fontSize: 12,
      ),
    );
  }

}