import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewsPortal extends Equatable {
  final news;

  NewsPortal({
    @required this.news,
  }) : super([news]);
}