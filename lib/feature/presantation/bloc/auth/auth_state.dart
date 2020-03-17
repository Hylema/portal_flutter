import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthCompletedState extends AuthState {}
class AuthFailState extends AuthState {}

class NeedAuthState extends AuthState {}
