
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
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NewsCubit>().refresh();
        },
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              return const LoadingView();
            } else if (state is NewsLoading) {
              return const LoadingView();
            } else if (state is NewsLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.articles.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return ArticleListItem(
                    article: article,
                    onTap: () => _navigateToArticleDetail(article),
                  );
                },
              );
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
        ),
      ),
    );
  }
}