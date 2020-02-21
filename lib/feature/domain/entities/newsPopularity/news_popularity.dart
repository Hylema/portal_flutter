import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewsPopularity extends Equatable {
  final popularity;

  NewsPopularity({
    @required this.popularity,
  }) : super([popularity]);
}

class UserLikesSeen extends Equatable {
  final bool seen;
  final bool liked;

  UserLikesSeen({
    @required this.seen,
    @required this.liked,
  }) : super([seen, liked]);
}