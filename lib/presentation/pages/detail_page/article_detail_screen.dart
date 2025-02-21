import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  final ScrollController _scrollController = ScrollController();

  ArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMMM d, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _formatAuthor(String byline) {
    return byline.startsWith('By ') ? byline.substring(3) : byline;
  }

  String _getShortDescription(String summary) {
    return summary.split('.').first + '.';
  }

  @override
  Widget build(BuildContext context) {
    final formattedAuthor = _formatAuthor(article.author);
    final formattedDate = _formatDate(article.date);
    final shortDescription = _getShortDescription(article.summary);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('NY Times Most Popular'),
      ),
      body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLargeScreen = constraints.maxWidth > 600;

              return SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isLargeScreen ? 800 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildArticleTitle(article.title, isLargeScreen),
                        SizedBox(height: isLargeScreen ? 16 : 12),
                        _buildShortDescription(shortDescription, context, isLargeScreen),
                        SizedBox(height: isLargeScreen ? 24 : 16),
                        _buildAuthorAndDateRow(formattedAuthor, formattedDate, context, isLargeScreen),
                        SizedBox(height: isLargeScreen ? 28 : 20),
                        _buildFeaturedImage(article.imageUrl, isLargeScreen),
                        const SizedBox(height: 8),
                        _buildSourceAttribution(isLargeScreen),
                        SizedBox(height: isLargeScreen ? 32 : 24),
                        _buildArticleSummary(article.summary, isLargeScreen),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // floatingActionButton: _buildScrollToTopButton(),
    );
  }

  Widget _buildArticleTitle(String title, bool isLargeScreen) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isLargeScreen ? 32 : 24,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );
  }

  Widget _buildShortDescription(String description, BuildContext context, bool isLargeScreen) {
    return Text(
      description,
      style: TextStyle(
        fontSize: isLargeScreen ? 16 : 12,
        color: Colors.grey[700],
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildAuthorAndDateRow(String author, String date, BuildContext context, bool isLargeScreen) {
    if (isLargeScreen) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildAuthorInfo(author, context, isLargeScreen),
          ),
          _buildDateInfo(date, isLargeScreen),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildAuthorInfo(author, context, isLargeScreen),
          ),
          _buildDateInfo(date, isLargeScreen),
        ],
      );
    }
  }

  Widget _buildAuthorInfo(String author, BuildContext context, bool isLargeScreen) {
    return Row(
      children: [
        _buildAuthorAvatar(author, context, isLargeScreen),
        SizedBox(width: isLargeScreen ? 12 : 8),
        Flexible(
          child: Text(
            author.isNotEmpty ? author : 'Unknown Author',
            style: TextStyle(
              fontSize: isLargeScreen ? 16 : 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorAvatar(String author, BuildContext context, bool isLargeScreen) {
    return CircleAvatar(
      radius: isLargeScreen ? 20 : 16,
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        author.isNotEmpty ? author[0].toUpperCase() : '?',
        style: TextStyle(
          color: Colors.white,
          fontSize: isLargeScreen ? 16 : 14,
        ),
      ),
    );
  }

  Widget _buildDateInfo(String date, bool isLargeScreen) {
    return Text(
      date,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: isLargeScreen ? 16 : 14,
      ),
    );
  }

  Widget _buildFeaturedImage(String imageUrl, bool isLargeScreen) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isLargeScreen ? 16 : 12),
      child: imageUrl.isNotEmpty
          ? _buildNetworkImage(imageUrl, isLargeScreen)
          : _buildImagePlaceholder(isLargeScreen),
    );
  }

  Widget _buildNetworkImage(String imageUrl, bool isLargeScreen) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: isLargeScreen ? 400 : 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(isLargeScreen),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildImageLoadingIndicator(loadingProgress, isLargeScreen);
      },
    );
  }

  Widget _buildImagePlaceholder(bool isLargeScreen) {
    return Container(
      height: isLargeScreen ? 400 : 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: Icon(Icons.image, size: isLargeScreen ? 64 : 48, color: Colors.grey),
    );
  }

  Widget _buildImageLoadingIndicator(ImageChunkEvent loadingProgress, bool isLargeScreen) {
    return Container(
      height: isLargeScreen ? 400 : 200,
      color: Colors.grey[300],
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }

  Widget _buildSourceAttribution(bool isLargeScreen) {
    return Center(
      child: Text(
        'Source: New York Times',
        style: TextStyle(
          fontSize: isLargeScreen ? 14 : 12,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildArticleSummary(String summary, bool isLargeScreen) {
    return Text(
      summary,
      style: TextStyle(
        fontSize: isLargeScreen ? 18 : 16,
        height: 1.6,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildScrollToTopButton() {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: const Icon(Icons.arrow_upward),
    );
  }
}