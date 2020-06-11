import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupervisorAppPage extends BlocDelegate {

  final Function snackBar;
  final BuildContext context;

  SupervisorAppPage({
    @required this.snackBar,
    @required this.context
  });

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) async {
    super.onError(bloc, error, stacktrace);
    print('----------------------------------------------------------------- $error');
    if(error is AuthException) {
      Navigator.pushNamed(context, '/auth');
      //Navigator.pushReplacementNamed(context, '/auth');
      return;
    }

    int seconds;
    String errorMessage = error.toString();

    if(error is ServerException) errorMessage = error.message;
    if(error is NetworkException) errorMessage = error.message;

    final int errorMessageLength = errorMessage.length;

    if(errorMessageLength > 20 && errorMessageLength < 40) seconds = 3;
    else if(errorMessageLength > 40 && errorMessageLength < 60) seconds = 4;
    else if(errorMessageLength > 69 && errorMessageLength < 80) seconds = 5;
    else if(errorMessageLength > 80 && errorMessageLength < 100) seconds = 6;
    else if(errorMessageLength > 100 && errorMessageLength < 120) seconds = 7;
    else if(errorMessageLength > 120 && errorMessageLength < 140) seconds = 8;
    else if(errorMessageLength > 140 && errorMessageLength < 160) seconds = 9;
    else seconds = 15;

    snackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: seconds),
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {},
          ),
        )
    );
  }
}