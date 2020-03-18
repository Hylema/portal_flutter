import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';

import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalState extends Equatable{
  NewsPortalState([List props = const <dynamic>[]]) : super(props);
}

class EmptyNewsPortal extends NewsPortalState {}
class LoadingNewsPortal extends NewsPortalState {}
class AuthNewsPortal extends NewsPortalState {}
class NeedAuthNewsPortal extends NewsPortalState {}

class LoadedNewsPortal extends NewsPortalState {
  final NewsPortalModel model;

  LoadedNewsPortal({@required this.model}) : super([model]);
}

class ErrorNewsPortal extends NewsPortalState {
  final String message;

  ErrorNewsPortal({@required this.message}) : super([message]);
}



class InitialNewsPortalState extends NewsPortalState {}
