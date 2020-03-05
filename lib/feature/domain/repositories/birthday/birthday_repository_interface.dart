import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/model.dart';
import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';

abstract class IBirthdayRepository {
  Future<Either<Failure, Birthday>> getBirthdayFromNetwork({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageIndex,
    @required int pageSize
  });
}