import 'package:meta/meta.dart';

@immutable
abstract class FieldsEvent {}

class BirthdayParametersFilter extends FieldsEvent {
  final periodFrom;
  final periodBy;
  final fio;
  final concreteDataDay;
  final concreteDataMonth;

  BirthdayParametersFilter({
    @required this.periodFrom,
    @required this.periodBy,
    @required this.fio,
    @required this.concreteDataDay,
    @required this.concreteDataMonth,
  });

}
class ParameterWithConcreteDay extends FieldsEvent {}
