import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AuthCodeEvent extends AuthEvent {
  final String code;
  AuthCodeEvent({@required this.code});
}

class NeedAuthEvent extends AuthEvent {}
