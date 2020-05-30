import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalEvent extends Equatable{
  NewsPortalEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchNewsEvent extends NewsPortalEvent {}
class UpdateNewsEvent extends NewsPortalEvent {}

