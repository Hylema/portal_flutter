import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';

class ServerException implements Exception {
  final String message = SERVER_EXCEPTION_MESSAGE;
}
class AuthException implements Exception {}
class BadRequestException implements Exception {
  final String message = BAD_REQUEST_EXCEPTION_MESSAGE;
}
class CacheException implements Exception {}
class ParserException implements Exception {}
class JsonException implements Exception {}
class UnknownException implements Exception {
  final String message = UNKNOWN_EXCEPTION_MESSAGE;
  final int code;

  UnknownException({@required this.code});
}
class NetworkException implements Exception {
  final String message = NETWORK_EXCEPTION_MESSAGE;
}