import 'package:meta/meta.dart';

@immutable
abstract class LikeNewsState {}

class InitialLikeNewsState extends LikeNewsState {}

class LoadedLikesState extends LikeNewsState {
  final int likes;
  final bool isLike;
  LoadedLikesState({@required this.likes, @required this.isLike});
}
