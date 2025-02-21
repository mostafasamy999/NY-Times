

import 'package:equatable/equatable.dart';

import '../../domain/entities/article.dart';

import 'package:equatable/equatable.dart';


abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;

  const NewsLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class NewsEmpty extends NewsState {
  final String message;

  const NewsEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}