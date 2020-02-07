import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfileFromNetwork();
  Future<Either<Failure, Profile>> getProfileFromCache();
}