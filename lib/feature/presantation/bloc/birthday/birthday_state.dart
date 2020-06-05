import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayState extends Equatable{
  @override
  List<Object> get props => [];
}

class BirthdayFromCacheState extends BirthdayState {
  final List birthdays;
  final String title;

  BirthdayFromCacheState({@required this.birthdays, @required this.title});
}
class NeedAuthBirthday extends BirthdayState {}
class LoadingBirthdayState extends BirthdayState {}

class NetworkFailLoadedCache extends BirthdayState {
  final BirthdayModel model;
  NetworkFailLoadedCache({@required this.model});
}

class LoadedBirthdayState extends BirthdayState {
  final List<BirthdayModel> birthdays;
  final bool hasReachedMax;
  final String title;

  LoadedBirthdayState({@required this.birthdays, this.hasReachedMax, @required this.title});

  LoadedBirthdayState copyWith({
    List<BirthdayModel> birthdays,
    bool hasReachedMax,
  }) {
    return LoadedBirthdayState(
        birthdays: birthdays ?? this.birthdays,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        title: title,
    );
  }

  @override
  List<Object> get props => [birthdays, hasReachedMax, title];
}

class ErrorBirthdayState extends BirthdayState {
  final String message;
  ErrorBirthdayState({@required this.message});
}
