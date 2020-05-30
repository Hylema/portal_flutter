import 'package:meta/meta.dart';

@immutable
abstract class LikeNewsEvent {}

class likeNewEvent extends LikeNewsEvent {
  final String guid;
  final String id;
  likeNewEvent({@required this.guid, @required this.id});
}

class removeLikeEvent extends LikeNewsEvent {
  final String guid;
  final String id;
  removeLikeEvent({@required this.guid, @required this.id});
}
