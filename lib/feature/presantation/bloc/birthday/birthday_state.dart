import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayState extends Equatable{
  BirthdayState([List props = const <dynamic>[]]) : super(props);
}

class EmptyBirthdayState extends BirthdayState {}
class NeedAuthBirthday extends BirthdayState {}
class LoadingBirthdayState extends BirthdayState {}
class LoadedBirthdayState extends BirthdayState {
  final BirthdayModel model;

  LoadedBirthdayState({@required this.model}) : super([model]);
}
class ErrorBirthdayState extends BirthdayState {
  final String message;

  ErrorBirthdayState({@required this.message}) : super([message]);
}
