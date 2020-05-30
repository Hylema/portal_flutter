import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';

abstract class IAuthRepository {
  Future<bool> authUser();
  Future<AuthState> checkAuth();
}