//import 'package:equatable/equatable.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_architecture_project/core/error/failure.dart';
//import 'package:flutter_architecture_project/core/usecases/usecase.dart';
//import 'package:dartz/dartz.dart';
//import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
//import 'package:flutter_architecture_project/feature/domain/entities/birthday/birthday.dart';
//import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
//import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
//
//class GetBirthdayFromNetworkWithConcreteDay implements UseCase<BirthdayModel, BirthdayParamsWithConcreteDay>{
//  final IBirthdayRepository repository;
//
//  GetBirthdayFromNetworkWithConcreteDay(this.repository);
//
//  @override
//  Future<Either<Failure, BirthdayModel>> call(BirthdayParamsWithConcreteDay params) async {
//    return await repository.getBirthdayWithConcreteDay(
//      monthNumber: params.monthNumber,
//      dayNumber: params.dayNumber,
//      pageSize: params.pageSize,
//      pageIndex: params.pageIndex,
//      update: params.update,
//    );
//  }
//}
//
//class BirthdayParamsWithConcreteDay extends Equatable {
//  final int monthNumber;
//  final int dayNumber;
//  final int pageSize;
//  final int pageIndex;
//  final bool update;
//
//  BirthdayParamsWithConcreteDay({
//    @required this.monthNumber,
//    @required this.dayNumber,
//    @required this.pageSize,
//    @required this.pageIndex,
//    @required this.update,
//  }) : super([monthNumber, dayNumber, pageSize, update]);
//}
//
//
//
//
//
//
//class GetBirthdayFromNetworkWithFilter implements UseCase<BirthdayModel, BirthdayParamsWithFilter>{
//  final IBirthdayRepository repository;
//
//  GetBirthdayFromNetworkWithFilter(this.repository);
//
//  @override
//  Future<Either<Failure, BirthdayModel>> call(BirthdayParamsWithFilter params) async {
//    return await repository.getBirthdayWithFilter(
//      monthNumber: params.monthNumber,
//      dayNumber: params.dayNumber,
//      pageSize: params.pageSize,
//      update: params.update,
//    );
//  }
//}
//
//class BirthdayParamsWithFilter extends Equatable {
//  final String fio;
//  final int startDayNumber;
//  final int endDayNumber;
//  final int startMonthNumber;
//  final int endMonthNumber;
//  final int pageSize;
//  final int pageIndex;
//  final bool update;
//
//  BirthdayParamsWithFilter({
//    @required this.pageSize,
//    @required this.pageIndex,
//    @required this.update,
//    this.fio,
//    this.startDayNumber,
//    this.endDayNumber,
//    this.startMonthNumber,
//    this.endMonthNumber,
//  }) : super([
//    pageSize, pageIndex, update,
//    fio, startDayNumber, endDayNumber,
//    startMonthNumber, endMonthNumber
//  ]);
//}