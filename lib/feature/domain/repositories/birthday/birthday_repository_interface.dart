import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';

abstract class IBirthdayRepository {
  Future<Either<Failure, Birthday>> getBirthdayFromNetwork(
      int monthNumber, int dayNumber, int pageIndex, int pageSize
      );
}