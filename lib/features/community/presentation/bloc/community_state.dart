import 'package:equatable/equatable.dart';

class Discussion {
  final String id;
  final String title;
  final String author;
  final String preview;
  final int replies;
  final String timeAgo;

  const Discussion({
    required this.id,
    required this.title,
    required this.author,
    required this.preview,
    required this.replies,
    required this.timeAgo,
  });
}

class Charity {
  final String id;
  final String name;
  final String description;
  final double goal;
  final double raised;
  final String category;

  const Charity({
    required this.id,
    required this.name,
    required this.description,
    required this.goal,
    required this.raised,
    required this.category,
  });
}

class Article {
  final String id;
  final String title;
  final String author;
  final String summary;
  final String readTime;
  final String category;

  const Article({
    required this.id,
    required this.title,
    required this.author,
    required this.summary,
    required this.readTime,
    required this.category,
  });
}

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object?> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<Discussion> discussions;
  final List<Charity> charities;
  final List<Article> articles;

  const CommunityLoaded({
    required this.discussions,
    required this.charities,
    required this.articles,
  });

  @override
  List<Object?> get props => [discussions, charities, articles];
}

class CommunityError extends CommunityState {
  final String message;

  const CommunityError(this.message);

  @override
  List<Object?> get props => [message];
}



