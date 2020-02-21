import 'package:meta/meta.dart';

@immutable
abstract class NewsPopularityEvent {}

class GetNewsPopularityEvent extends NewsPopularityEvent {
  final id;

  GetNewsPopularityEvent({this.id});
}

class LoadingPopularityEvent extends NewsPopularityEvent {}