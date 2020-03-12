import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayState {}

class EmptyBirthdayState extends BirthdayState {}

class NeedAuthBirthday extends BirthdayState {}

class NetworkFailLoadedCache extends BirthdayState {
  final BirthdayModel model;
  NetworkFailLoadedCache({@required this.model});
}

class LoadingBirthdayState extends BirthdayState {}

class LoadedBirthdayState extends BirthdayState {
  final BirthdayModel model;
  LoadedBirthdayState({@required this.model});

  static LoadedBirthdayState getInstance({@required BirthdayModel model}) =>
      LoadedBirthdayState(model: model);
}

class ErrorBirthdayState extends BirthdayState {
  final String message;
  ErrorBirthdayState({@required this.message});

  static ErrorBirthdayState getInstance({@required String message}) =>
      ErrorBirthdayState(message: message);
}
