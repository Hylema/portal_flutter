import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';

class BlocHelper<Type> {
  Future<Type> eitherLoadedOrErrorState({
    @required Either either,
     ifNeedAuth,
    @required  ifError,
    @required  ifLoaded,
  }) async {
    return await either.fold(
          (failure){
        if(failure is AuthFailure){
          return ifNeedAuth;
        }
        return ifError(message: mapFailureToMessage(failure));
      },
          (model){
        return ifLoaded(model: model);
      },
    );
  }

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

  Map<String, String> createParams({@required Map map}){
    Map params = {};

    map.forEach((key, value) {
      if (value != null && value != '') params[key] = '$value';
    });

    return Map<String, String>.from(params);
  }
}