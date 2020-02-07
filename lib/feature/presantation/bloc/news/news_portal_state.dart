import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';

import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalState extends Equatable{
  NewsPortalState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends NewsPortalState {}
class Loading extends NewsPortalState {}
class Loaded extends NewsPortalState {
  final NewsPortal model;

  Loaded({@required this.model}) : super([model]){
    print('model ==== $model');
    GlobalData.news = model.news;
  }
}

class Error extends NewsPortalState {
  final String message;

  Error({@required this.message}) : super([message]);
}



class InitialNewsPortalState extends NewsPortalState {}