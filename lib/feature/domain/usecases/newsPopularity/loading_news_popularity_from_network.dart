import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/usecases/usecase.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/newsPopularity/news_popularity_repository_interface.dart';
import 'package:dartz/dartz.dart';

class LoadingNewsPopularityFromNetwork implements UseCase<List<DocumentSnapshot>, NoParams>{
  final INewsPopularityRepository repository;

  LoadingNewsPopularityFromNetwork(this.repository);

  @override
  Future<Either<Failure, List<DocumentSnapshot>>> call(NoParams params) async {
    return await repository.loadingPopularity();
  }
}
