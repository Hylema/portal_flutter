import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfileFromNetwork();
  Future<Either<Failure, ProfileModel>> getProfileFromCache();
}