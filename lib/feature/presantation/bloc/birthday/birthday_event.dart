import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent {}

class LoadMoreBirthdayEvent extends BirthdayEvent {}
class UpdateBirthdayEvent extends BirthdayEvent {}

class SetFilterBirthdayEvent extends BirthdayEvent {
  final fio;
  final startDayNumber;
  final endDayNumber;
  final startMonthNumber;
  final endMonthNumber;
  final titleDate;

  SetFilterBirthdayEvent({
    this.fio,
    this.startDayNumber,
    this.endDayNumber,
    this.startMonthNumber,
    this.endMonthNumber,
    this.titleDate,
  });
}

class ResetFilterBirthdayEvent extends BirthdayEvent{}
