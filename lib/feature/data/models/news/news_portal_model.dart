import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';
import 'package:meta/meta.dart';

class NewsPortalModel extends NewsPortal {
  NewsPortalModel({
    @required news,
  }) : super(
    news: news,
  );

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