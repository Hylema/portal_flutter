import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthCompletedState extends AuthState {}
class AuthFailedState extends AuthState {}

class NeedAuthState extends AuthState {}
