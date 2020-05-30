import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/profile/profile_repository_interface.dart';
import 'package:meta/meta.dart';

class ProfileRepository implements IProfileRepository{
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<ProfileModel> fetchProfile() async {
    ProfileModel model = await remoteDataSource.getProfile();

    await saveProfileToCache(model: model);

    return model;
  }

  @override
  ProfileModel getProfileFromCache() =>
      localDataSource.getProfileFromCache();

  @override
  Future<void> saveProfileToCache({@required ProfileModel model}) async =>
      await localDataSource.saveProfileToCache(model: model);

}