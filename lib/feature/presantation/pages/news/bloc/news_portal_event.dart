import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalEvent extends Equatable{
  NewsPortalEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchNewsEvent extends NewsPortalEvent {}
class UpdateNewsEvent extends NewsPortalEvent {}
class LikeNewsEvent extends NewsPortalEvent {
  final int index;
  final String id;
  final String guid;

  LikeNewsEvent({@required this.index, @required this.id, @required this.guid});
}
class RemoveLikeEvent extends NewsPortalEvent {
  final int index;
  final String id;
  final String guid;

  RemoveLikeEvent({@required this.index, @required this.id, @required this.guid});
}

