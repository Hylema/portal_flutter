import 'package:meta/meta.dart';

class NewsPopularityModel {
  final popularity;

  NewsPopularityModel({
    @required this.popularity,
  });

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