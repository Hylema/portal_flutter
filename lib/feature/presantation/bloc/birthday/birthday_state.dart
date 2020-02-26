import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayState {}

class EmptyBirthdayState extends BirthdayState {}
class LoadingBirthdayState extends BirthdayState {}
class LoadedBirthdayState extends BirthdayState {
  final BirthdayModel model;

  LoadedBirthdayState({@required this.model});
}
class ErrorBirthdayState extends BirthdayState {
  final String message;

  ErrorBirthdayState({@required this.message});
}
