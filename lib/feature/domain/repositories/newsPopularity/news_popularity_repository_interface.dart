import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/domain/entities/newsPopularity/news_popularity.dart';

abstract class INewsPopularityRepository {
  /// Получаем кол-во лайков и просмотров определенной страницы из Firebase по её id
  Future<Either<Failure, NewsPopularity>> getNewsPopularity(int id);

  /// Проверяем просматривал ли пользовать конкретную страницы и понравилась ли она ему или нет
  Future<Either<Failure, UserLikesSeen>> getNewsPopularityUserFromJson(int id);

  ///Пользователю понравилась эта страница, записываем её в json
  Future<Either<Failure, bool>> setUserLikedPageToJson(int id, List page);

  ///Пользователю впервые увидел эту запись, записываем её в json
  Future<Either<Failure, bool>> setUserSeePage(int newsId);

  ///Загружаем все документы Firebase в json
  Future<Either<Failure, List<DocumentSnapshot>>> loadingPopularity();
}