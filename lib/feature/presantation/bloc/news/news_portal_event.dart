import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalEvent extends Equatable{
  NewsPortalEvent([List props = const <dynamic>[]]) : super(props);
}

class GetNewsPortalFromNetworkBlocEvent extends NewsPortalEvent {
  final int skip;
  final int top;
  final bool shimmer;

  GetNewsPortalFromNetworkBlocEvent({
    @required this.skip,
    @required this.top,
    this.shimmer = false
  }) : super([skip, top]);
}

class GetNewsPortalFromCacheBlocEvent extends NewsPortalEvent {
  final bool shimmer;

  GetNewsPortalFromCacheBlocEvent({
    this.shimmer = false
  }) : super([]);
}

