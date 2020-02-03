import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news_portal.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/news_portal_repository.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class GetNewsPortal implements UseCase<NewsPortal, Params>{
  final NewsPortalRepository repository;

  GetNewsPortal(this.repository);

  @override
  Future<Either<Failure, NewsPortal>> call(Params params) async {
    return await repository.getNewsPortal(params.skip, params.top);
  }
}

class Params extends Equatable {
  final int skip;
  final int top;

  Params({
    @required this.skip,
    @required this.top,
  }) : super([skip, top]);
}