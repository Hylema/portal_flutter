import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent {}

class GetBirthdayEvent extends BirthdayEvent {
  final int monthNumber;
  final int dayNumber;
  final int pageSize;
  final int pageIndex;

  GetBirthdayEvent({
    @required this.monthNumber,
    @required this.dayNumber,
    @required this.pageSize,
    @required this.pageIndex,
  });
}

class UpdateBirthdayNetwork extends BirthdayEvent {}