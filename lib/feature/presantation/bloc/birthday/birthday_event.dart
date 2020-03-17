import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchBirthdayEvent extends BirthdayEvent {}
class UpdateBirthdayEvent extends BirthdayEvent {}

class SetFilterBirthdayEvent extends BirthdayEvent {
  final String fio;
  final int startDayNumber;
  final int endDayNumber;
  final int startMonthNumber;
  final int endMonthNumber;
  final String title;

  SetFilterBirthdayEvent({
    this.fio,
    this.startDayNumber,
    this.endDayNumber,
    this.startMonthNumber,
    this.endMonthNumber,
    this.title,
  });
}

class ResetFilterBirthdayEvent extends BirthdayEvent{}
