import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {}
class ClientFailure extends Failure {}

class NetworkFailure extends Failure {
  final modelFromCache;

  NetworkFailure({this.modelFromCache});
}

class CacheFailure extends Failure {}

class ParserProfileFailure extends Failure {}

class AuthFailure extends Failure {}

class JsonFailure extends Failure {}

class UnknownErrorFailure extends Failure {}
class BadRequestFailure extends Failure {}

class ProgrammerFailure extends Failure {
  final errorMessage;

  ProgrammerFailure({@required this.errorMessage}) : super([errorMessage]);
}