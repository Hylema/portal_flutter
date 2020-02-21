import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/status_code.dart';

const String SERVER_FAILURE_MESSAGE = 'Ошибка при получении данных';
const String CACHE_FAILURE_MESSAGE = 'Ошибка при получении данных из кэша';
const String NETWORK_FAILURE_MESSAGE = 'Ошибка при подключении к сети';
const String JSON_FAILURE_MESSAGE = 'Ошибка при получении данных из json';
const String UNKNOWN_ERROR_FAILURE = 'Произошла ошибка';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return '$SERVER_FAILURE_MESSAGE ${Status.code == null ? '' : ', статус код: ${Status.code}'}';
    case UnknownErrorFailure:
      return '$UNKNOWN_ERROR_FAILURE ${Status.message == null ? '' : ': ${Status.message}'}';
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case NetworkFailure:
      return NETWORK_FAILURE_MESSAGE;
    case JsonFailure:
      return JSON_FAILURE_MESSAGE;
    default:
      return 'Неизвестная ошибка';
  }
}