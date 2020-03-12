import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent {}

class LoadMoreBirthdayWithConcreteDayEvent extends BirthdayEvent {
  final int monthNumber;
  final int dayNumber;
  final int pageSize;
  final int pageIndex;
  final bool update;

  LoadMoreBirthdayWithConcreteDayEvent({
    @required this.monthNumber,
    @required this.dayNumber,
    @required this.pageSize,
    @required this.pageIndex,
    @required this.update,
  });
}

class LoadMoreBirthdayWithFilterEvent extends BirthdayEvent {
  final String fio;
  final int startDayNumber;
  final int endDayNumber;
  final int startMonthNumber;
  final int endMonthNumber;
  final int pageSize;
  final int pageIndex;
  final bool update;

  LoadMoreBirthdayWithFilterEvent({
    @required this.pageSize,
    @required this.pageIndex,
    @required this.update,
    this.fio,
    this.startDayNumber,
    this.endDayNumber,
    this.startMonthNumber,
    this.endMonthNumber,
  });
}
