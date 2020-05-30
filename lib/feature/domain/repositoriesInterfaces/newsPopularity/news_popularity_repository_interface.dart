//import 'package:dartz/dartz.dart';
//import 'package:flutter_architecture_project/feature/data/models/newsPopularity/news_popularity_model.dart';
//
//abstract class INewsPopularityRepository {
//  /// Получаем кол-во лайков и просмотров определенной страницы из Firebase по её id
//  Future<Either<Failure, NewsPopularityModel>> getNewsPopularity(int id);
//
//  /// Проверяем просматривал ли пользовать конкретную страницы и понравилась ли она ему или нет
//  Future<Either<Failure, NewsPopularityModel>> getNewsPopularityUserFromJson(int id);
//
//  ///Пользователю понравилась эта страница, записываем её в json
//  Future<Either<Failure, bool>> setUserLikedPageToJson(int id, List page);
//
//  ///Пользователю впервые увидел эту запись, записываем её в json
//  Future<Either<Failure, bool>> setUserSeePage(int newsId);
//}