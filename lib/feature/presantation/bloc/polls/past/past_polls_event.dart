import 'package:meta/meta.dart';

@immutable
abstract class PastPollsEvent {}

class FetchPastPolls extends PastPollsEvent {}