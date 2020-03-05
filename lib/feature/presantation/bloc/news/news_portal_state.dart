import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';

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
  final NewsPortal model;

  LoadedNewsPortal({@required this.model}) : super([model]);
}

class ErrorNewsPortal extends NewsPortalState {
  final String message;

  ErrorNewsPortal({@required this.message}) : super([message]);
}



class InitialNewsPortalState extends NewsPortalState {}
