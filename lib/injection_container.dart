import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_architecture_project/core/api/token/auth_token.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:flutter_architecture_project/core/until/input_converter.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/repositories/news/news_portal_repository_impl.dart';
import 'package:flutter_architecture_project/feature/data/repositories/profile/profile_repository_impl.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/news/news_portal_repository.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/profile/profile_repository.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/news/get_news_portal_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/news/get_news_portal_from_network.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_network.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  ///! Features - Number Trivia
  sl.registerFactory(
        () => NewsPortalBloc(
          getNewsFromNetwork: sl(),
          getNewsFromCache: sl(),
    ),
  );

  sl.registerFactory(
        () => ProfileBloc(
          getProfileFormNetwork: sl(),
          getProfileFromCache: sl()
    ),
  );

  sl.registerFactory(() => AppBloc(),);

  /// Use cases
  sl.registerLazySingleton(() => GetNewsPortalFormNetwork(sl()));
  sl.registerLazySingleton(() => GetNewsPortalFromCache(sl()));

  sl.registerLazySingleton(() => GetProfileFormNetwork(sl()));
  sl.registerLazySingleton(() => GetProfileFromCache(sl()));

  /// Repository
  sl.registerLazySingleton<NewsPortalRepository>(
        () => NewsPortalRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// Data sources
  sl.registerLazySingleton<NewsPortalRemoteDataSource>(
        () => NewsPortalRemoteDataSourceImpl(
            client: sl(),
        ),
  );
  sl.registerLazySingleton<NewsPortalLocalDataSource>(
        () => NewsPortalLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(
        client: sl(),
        parser: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalDataSourceImpl(
          sharedPreferences: sl(),
        ),
  );

  ///! Core
  sl.registerLazySingleton<AuthToken>(() => AuthToken());
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => ProfileParser());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}