import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';

abstract class IAuthRepository {
  Future<bool> authUser();
  Future<AuthState> checkAuth();
}