import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/repositories/auth/auth_repository.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => InitialAuthState();

  final AuthRepository authRepository;
  AuthBloc({@required this.authRepository});

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AuthCodeEvent) yield* _authUser(code: event.code);
    if(event is CheckAuthEvent) yield await authRepository.checkAuth();
  }


  Stream<AuthState> _authUser({@required String code}) async* {
    if(await authRepository.authUser(code: code)) yield AuthCompletedState();
  }
}
