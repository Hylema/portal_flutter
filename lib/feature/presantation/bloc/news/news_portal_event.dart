import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsPortalEvent extends Equatable{
  NewsPortalEvent([List props = const <dynamic>[]]) : super(props);
}

class GetNewsPortalFromNetworkBlocEvent extends NewsPortalEvent {
  final skip;
  final top;

  GetNewsPortalFromNetworkBlocEvent(this.skip, this.top) : super([skip, top]);
}

class GetNextNewsPortalBloc extends NewsPortalEvent {
  final skip;
  final top;

  GetNextNewsPortalBloc(this.skip, this.top) : super([skip, top]);
}

class RefreshNewsPortalBloc extends NewsPortalEvent {
  final skip;
  final top;

  RefreshNewsPortalBloc(this.skip, this.top) : super([skip, top]);
}

class GetNewsPortalFromCacheBlocEvent extends NewsPortalEvent {
  final skip;
  final top;

  GetNewsPortalFromCacheBlocEvent(this.skip, this.top) : super([skip, top]);
}

