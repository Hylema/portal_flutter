import 'package:flutter_architecture_project/feature/domain/entities/newsPopularity/news_popularity.dart';
import 'package:meta/meta.dart';

class NewsPopularityModel extends NewsPopularity {
  NewsPopularityModel({
    @required popularity,
  }) : super(
    popularity: popularity,
  );

  factory NewsPopularityModel.fromJson(json) {
    return NewsPopularityModel(
      popularity: json['popularity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'popularity': popularity,
    };
  }
}