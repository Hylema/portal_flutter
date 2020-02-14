import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/profile/profile_repository.dart';
class GetProfileFromCache extends UseCase<Profile, NoParams> {
  final IProfileRepository repository;

  GetProfileFromCache(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await repository.getProfileFromCache();
  }
}