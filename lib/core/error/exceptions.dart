import 'package:flutter/cupertino.dart';

class ServerException implements Exception {
  final String message;
  ServerException({@required this.message});
}
class AuthException implements Exception {}
class BadRequestException implements Exception {}
class CacheException implements Exception {}
class ParserException implements Exception {}
class JsonException implements Exception {}
class UnknownException implements Exception {
  final int code;

  UnknownException({@required this.code});
}