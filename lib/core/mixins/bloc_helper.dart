import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';

class BlocHelper<Type> {
  Future eitherLoadedOrErrorState({
    @required Either either,
     ifNeedAuth,
    @required  ifError,
    @required  ifLoaded,
  }) async {
    try{
      return await either.fold(
            (failure){
          if(failure is AuthFailure){
            return NeedAuthBirthday();
          }
          return ErrorBirthdayState(message: mapFailureToMessage(failure));
        },
            (model){
          return LoadedBirthdayState(model: model);
        },
      );
    } catch(e){
      print(' = = = = = = = = = = =   =    = == ==== $e');
    }
  }
}