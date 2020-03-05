import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';

class GetBirthdayFromNetwork implements UseCase<Birthday, BirthdayParams>{
  final IBirthdayRepository repository;

  GetBirthdayFromNetwork(this.repository);

  @override
  Future<Either<Failure, Birthday>> call(BirthdayParams params) async {
    return await repository.getBirthdayFromNetwork(
        monthNumber: params.monthNumber,
        dayNumber: params.dayNumber,
        pageIndex: params.pageIndex,
        pageSize: params.pageSize
    );
  }
}

class BirthdayParams extends Equatable {
  final int monthNumber;
  final int dayNumber;
  final int pageIndex;
  final int pageSize;

  BirthdayParams({
    @required this.monthNumber,
    @required this.dayNumber,
    @required this.pageIndex,
    @required this.pageSize,
  }) : super([monthNumber, dayNumber, pageIndex, pageSize]);
}