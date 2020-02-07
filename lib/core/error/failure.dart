import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {
  final statusCode;
  ServerFailure({this.statusCode}) : super([statusCode]);
}

class NetworkFailure extends Failure {}

class CacheFailure extends Failure {}

class ParserProfileFailure extends Failure {}

class AuthFailure extends Failure {}