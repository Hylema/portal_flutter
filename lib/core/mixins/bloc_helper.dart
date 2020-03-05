import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';

class BlocHelper {
  Future eitherLoadedOrErrorState({
    @required Either either,
    ifNeedAuth,
    @required ifError,
    @required ifLoaded,
  }) async {
    return await either.fold(
          (failure){
        if(failure is AuthFailure){
          return ifNeedAuth();
        }
        print('ошибка');
        return ErrorBirthdayState(message: mapFailureToMessage(failure));
      },
          (model){
        return ifLoaded(model: model);
      },
    );
  }
}