import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_architecture_project/feature/data/models/newsPopularity/news_popularity_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsPopularityState {}

class EmptyNewsPopularityState extends NewsPopularityState {}
class LoadingNewsPopularity extends NewsPopularityState {}
class LoadedPopularity extends NewsPopularityState {
  final List<DocumentSnapshot> popularity;

  LoadedPopularity({@required this.popularity});
}
class LoadedNewsPopularity extends NewsPopularityState {
  final NewsPopularityModel model;

  LoadedNewsPopularity({@required this.model});
}

class ErrorNewsPopularity extends NewsPopularityState {
  final String message;

  ErrorNewsPopularity({@required this.message});
}