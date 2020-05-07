import 'package:meta/meta.dart';

@immutable
abstract class CurrentPollsEvent {}

class FetchCurrentPolls extends CurrentPollsEvent {}