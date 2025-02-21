import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times/presentation/pages/home_list_page/widget/article_list_item.dart';

import '../../../app_router.dart';
import '../../../domain/entities/article.dart';
import '../../common_widget/empty_view.dart';
import '../../common_widget/error_view.dart';
import '../../common_widget/load_view.dart';
import '../detail_page/article_detail_screen.dart';
import '../news_cubit.dart';
import '../news_state.dart';

class NewsListingScreen extends StatefulWidget {
  const NewsListingScreen({Key? key}) : super(key: key);

  @override
  State<NewsListingScreen> createState() => _NewsListingScreenState();
}

class _NewsListingScreenState extends State<NewsListingScreen> {
  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  void _loadNews() {
    context.read<NewsCubit>().fetchNews();
  }

  void _navigateToArticleDetail(Article article) {
    Navigator.pushNamed(
      context,
      AppRouter.articleDetail,
      arguments: article,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NY Times Most Popular'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<NewsCubit>().refresh();
            },
            child: _buildNewsList(constraints),
          );
        },
      ),
    );
  }

  Widget _buildNewsList(BoxConstraints constraints) {
    final isLargeScreen = constraints.maxWidth > 600;

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial || state is NewsLoading) {
          return const LoadingView();
        } else if (state is NewsLoaded) {
          return _buildArticleListView(state.articles, isLargeScreen, constraints);
        } else if (state is NewsEmpty) {
          return EmptyView(
            message: state.message,
            onRefresh: _loadNews,
          );
        } else if (state is NewsError) {
          return ErrorView(
            errorMessage: state.message,
            onRetry: _loadNews,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildArticleListView(List<Article> articles, bool isLargeScreen, BoxConstraints constraints) {
    if (isLargeScreen) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: _buildResponsiveLayout(articles, constraints),
        ),
      );
    }
    else {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final article = articles[index];
          return ArticleListItem(
            article: article,
            onTap: () => _navigateToArticleDetail(article),
          );
        },
      );
    }
  }

  Widget _buildResponsiveLayout(List<Article> articles, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    int columnCount = 1;

    if (width > 900) {
      columnCount = 3;
    } else if (width > 600) {
      columnCount = 2;
    }

    if (columnCount > 1) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () => _navigateToArticleDetail(article),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _buildGridArticleItem(article),
              ),
            ),
          );
        },
      );
    }
    else {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final article = articles[index];
          return ArticleListItem(
            article: article,
            onTap: () => _navigateToArticleDetail(article),
          );
        },
      );
    }
  }

  Widget _buildGridArticleItem(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.author,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              article.author,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _formatDate(article.date),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    } catch (e) {
      return date;
    }
  }
}