import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';

abstract class IBirthdayRepository {
  Future<Either<Failure, List<BirthdayModel>>> getBirthdayWithConcreteDay({
    @required BirthdayParams params,
  });

  Future<Either<Failure, List<BirthdayModel>>> getBirthdayWithFilter({
    @required BirthdayParams params,
  });

  Future<Either<Failure, BirthdayModel>> getBirthdayFromCache();

  Future<void> setBirthdayToCache();
}