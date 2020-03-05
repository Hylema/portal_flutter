import 'package:flutter_architecture_project/core/error/failure.dart';

const String CACHE_FAILURE_MESSAGE = 'Ошибка при получении данных из кэша';
const String JSON_FAILURE_MESSAGE = 'Ошибка при получении данных из json';
const String NETWORK_FAILURE_MESSAGE = 'Ошибка при подключении к сети';

const String SERVER_FAILURE_MESSAGE = 'Ошибка сервера, статус код: 500';
const String BAD_REQUEST_MESSAGE = 'Ошибка, неверно переданы параметры';
const String UNKNOWN_ERROR_FAILURE = 'Неизвестная ошибка';

String mapFailureToMessage(failure) {
  if(failure is ServerFailure)
    return SERVER_FAILURE_MESSAGE;

  else if(failure is UnknownErrorFailure)
    return UNKNOWN_ERROR_FAILURE;

  else if(failure is CacheFailure)
    return CACHE_FAILURE_MESSAGE;

  else if(failure is NetworkFailure)
    return NETWORK_FAILURE_MESSAGE;

  else if(failure is JsonFailure)
    return JSON_FAILURE_MESSAGE;

  else if(failure is BadRequestFailure)
    return BAD_REQUEST_MESSAGE;

  else if(failure is ProgrammerFailure){
    ///TypeError errorMessage;
    return '${failure.errorMessage}';
  }
}