import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:flutter_architecture_project/feature/data/datasources/auth/auth_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/auth/auth_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/main/main_params_json_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/polls/polls_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/videoGallery/video_gallery_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/repositories/auth/auth_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/birthday/birthday_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/error_catcher.dart';
import 'package:flutter_architecture_project/feature/data/repositories/main/main_params_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/news/news_portal_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/polls/polls_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/profile/profile_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/videoGallery/video_gallery_repository.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/main/main_params_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/polls/polls_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/videoGallery/video_gallery_repository_interface.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/pageLoading/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/current/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/past/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {




  ///! BLOCS

  /// news portal
  sl.registerFactory(() => NewsPortalBloc(
    networkInfo: sl(),
    repository: sl()
  ));

  /// auth
  sl.registerFactory(() => AuthBloc(
      authRepository: sl()
  ));

  ///pageLoading
  sl.registerFactory(() => PageLoadingBloc());

//  /// profile
//  sl.registerFactory(
//        () => ProfileBloc(
//        getProfileFormNetwork: sl(),
//        getProfileFromCache: sl()
//    ),
//  );
//
  /// main params page
  sl.registerFactory(
        () => MainBloc(
          repository: sl()
    ),
  );

  /// video gallery
  sl.registerFactory(
        () => VideoGalleryBloc(
        networkInfo: sl(),
        repository: sl()
    ),
  );

  /// birthday
  sl.registerFactory(
        () => BirthdayBloc(
          repository: sl(),
          networkInfo: sl()
    ),
  );

  /// selected index
  sl.registerFactory(() => SelectedIndexBloc());

  ///polls
  sl.registerFactory(() => PastPollsBloc(
    networkInfo: sl(),
    repository: sl()
  ));
  sl.registerFactory(() => CurrentPollsBloc(
      networkInfo: sl(),
      repository: sl()
  ));








  ///! REPOSITORY

  /// news portal
  sl.registerLazySingleton<INewsPortalRepository>(
        () => NewsPortalRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
//
//  /// profile
//  sl.registerLazySingleton<IProfileRepository>(
//        () => ProfileRepository(
//      remoteDataSource: sl(),
//      localDataSource: sl(),
//      networkInfo: sl(),
//    ),
//  );
//
  /// main params page
  sl.registerLazySingleton<IMainParamsRepository>(
        () => MainParamsRepository(
      localDataSource: sl(),
    ),
  );
//
//  /// likes/seen
//  sl.registerLazySingleton<INewsPopularityRepository>(
//        () => NewsPopularityRepository(
//        networkInfo: sl(),
//        remoteDataSource: sl()
//    ),
//  );

  /// video gallery
  sl.registerLazySingleton<IVideoGalleryRepository>(
        () => VideoGalleryRepository(
        remoteDataSource: sl()
    ),
  );
  /// auth
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );


  /// birthday
  sl.registerLazySingleton<IBirthdayRepository>(
        () => BirthdayRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
    ),
  );

  ///polls
  sl.registerLazySingleton<PollsRepository>(
        () => PollsRepository(
        remoteDataSource: sl(),
        networkInfo: sl()
    ),
  );




  ///! DATA SOURCE

  /// news portal
  sl.registerLazySingleton<NewsPortalRemoteDataSource>(
        () => NewsPortalRemoteDataSource(
        client: sl(),
        storage: sl()
    ),
  );
  sl.registerLazySingleton<NewsPortalLocalDataSource>(
        () => NewsPortalLocalDataSource(sharedPreferences: sl(), cachedName: CACHE_NEWS),
  );

  /// profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSource(
        client: sl(),
        parser: sl(),
        storage: sl()
    ),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalDataSource(
      sharedPreferences: sl(),
    ),
  );

  /// main params page
  sl.registerLazySingleton<MainParamsJsonDataSource>(
        () => MainParamsJsonDataSource(
          cachedName: CACHE_POSITION_PAGES,
          sharedPreferences: sl()
        ),
  );

  /// video gallery
  sl.registerLazySingleton<VideoGalleryRemoteDataSource>(
        () => VideoGalleryRemoteDataSource(
        client: sl(),
        storage: sl()
    ),
  );

  /// birthday
  sl.registerLazySingleton<BirthdayRemoteDataSource>(
        () => BirthdayRemoteDataSource(
        storage: sl(),
        client: sl()
    ),
  );
  sl.registerLazySingleton<BirthdayLocalDataSource>(
        () => BirthdayLocalDataSource(
          cachedName: CACHE_BIRTHDAY,
          sharedPreferences: sl()
    ),
  );

  /// auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(
        client: sl()
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSource(
          flutterSecureStorage: sl(),
          storage: sl()
    ),
  );

  ///polls
  sl.registerLazySingleton<PollsRemoteDataSource>(
        () => PollsRemoteDataSource(
        client: sl(),
        storage: sl()
    ),
  );


  ///! CORE
  sl.registerLazySingleton<Storage>(() => Storage());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<ProfileParser>(() => ProfileParser());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ErrorCatcher>(() => ErrorCatcher(networkInfo: sl()));




  ///! EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}