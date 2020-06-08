import 'package:meta/meta.dart';

@immutable
abstract class PollsEvent {}

class FetchPastPollsEvent extends PollsEvent {}
class FetchCurrentPollsEvent extends PollsEvent {}