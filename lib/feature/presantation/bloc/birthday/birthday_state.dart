import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news_portal.dart';

@immutable
abstract class BirthdayState extends Equatable{
  BirthdayState([List props = const <dynamic>[]]) : super(props);
}

class Emptyy extends BirthdayState {}
class Loadingg extends BirthdayState {}
class Loadedd extends BirthdayState {
  final NewsPortal model;

  Loadedd({@required this.model}) : super([model]);
}

class Errorr extends BirthdayState {
  final String message;

  Errorr({@required this.message}) : super([message]);
}



class InitialBirthdayState extends BirthdayState {}
