import 'package:meta/meta.dart';

class NewsPortalModel {
  final news;

  NewsPortalModel({
    @required this.news,
  });

  factory NewsPortalModel.fromJson(json) {
    return NewsPortalModel(
      news: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': news,
    };
  }
}