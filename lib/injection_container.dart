import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/core/until/input_converter.dart';
import 'package:flutter_architecture_project/feature/data/datasources/data_news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/data_news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/repositories/news_portal_repository_impl.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/news_portal_repository.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/get_news_portal.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  sl.registerFactory(
        () => NewsPortalBloc(
      news: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNewsPortal(sl()));

  // Repository
  sl.registerLazySingleton<NewsPortalRepository>(
        () => NewsPortalRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NewsPortalRemoteDataSource>(
        () => NewsPortalRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<NewsPortalLocalDataSource>(
        () => NewsPortalLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}