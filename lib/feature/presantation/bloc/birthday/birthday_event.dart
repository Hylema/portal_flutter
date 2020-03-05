import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent {}

class GetBirthdayEvent extends BirthdayEvent {
  final int monthNumber;
  final int dayNumber;
  final int pageIndex;
  final int pageSize;

  GetBirthdayEvent({
    @required this.monthNumber,
    @required this.dayNumber,
    @required this.pageIndex,
    @required this.pageSize,
  });
}

class GetBirthdayFromCache extends BirthdayEvent {}