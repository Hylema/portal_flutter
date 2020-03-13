import 'package:meta/meta.dart';

@immutable
abstract class FieldsState {}

class InitialFieldsState extends FieldsState {}
class ParametersWithConcreteDayState extends FieldsState {}
class ParametersWithFilterState extends FieldsState {}
