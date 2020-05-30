import 'package:flutter_architecture_project/feature/data/datasources/auth/auth_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/auth/auth_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/first_token_model.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/second_token_model.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/auth/auth_repository_interface.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';

import 'package:meta/meta.dart';

class AuthRepository implements IAuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.profileRemoteDataSource,
  });

  @override
  Future<bool> authUser({@required code}) async {
    final FirstTokenModel firstToken = await remoteDataSource.getFirstToken(code: code);
    final SecondTokenModel secondToken = await remoteDataSource.getSecondToken(refreshToken: firstToken.refreshToken);

    localDataSource.saveTokens(
      firstToken: firstToken.accessToken,
      secondToken: secondToken.accessToken,
    );

    final ProfileModel profileModel = await profileRemoteDataSource.getProfile();
    final CurrentUserModel currentUserModel = await remoteDataSource.getCurrentUser(email: profileModel.email);

    localDataSource.saveData(
        currentUserModel: currentUserModel
    );

    return true;
  }

  @override
  Future<AuthState> checkAuth() async => await remoteDataSource.checkAuth();

}

