import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/core/parsers/profile_parser.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/main/main_params_json_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/newsPopularity/news_popularity_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/profile/profile_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/videoGallery/video_gallery_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/repositories/birthday/birthday_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/error_catcher.dart';
import 'package:flutter_architecture_project/feature/data/repositories/main/main_params_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/news/news_portal_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/newsPopularity/news_popularity_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/profile/profile_repository.dart';
import 'package:flutter_architecture_project/feature/data/repositories/videoGallery/video_gallery_repository.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/main/main_params_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/news/news_portal_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/newsPopularity/news_popularity_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/profile/profile_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositories/videoGallery/video_gallery_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/main/get_main_params_from_json.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/main/set_main_params_to_json.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/news/get_news_portal_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/news/get_news_portal_from_network.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/get_news_popularity_by_id.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/get_news_popularity_user_from_json.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/loading_news_popularity_from_network.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/set_user_liked_page_to_json.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/newsPopularity/set_user_see_page.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_cache.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/profile/get_profile_from_network.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/videoGallery/get_video_gallery_from_network.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/blocsResponses/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/fields/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/newsPopularity/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {




  ///! BLOCS

  /// news portal
  sl.registerFactory(
        () => NewsPortalBloc(
      getNewsFromNetwork: sl(),
      getNewsFromCache: sl(),
    ),
  );

  /// profile
  sl.registerFactory(
        () => ProfileBloc(
        getProfileFormNetwork: sl(),
        getProfileFromCache: sl()
    ),
  );

  /// main params page
  sl.registerFactory(
        () => MainBloc(
        getMainParamsFromJson: sl(),
        setMainParamsToJson: sl()
    ),
  );

  /// likes/seen
  sl.registerFactory(
        () => NewsPopularityBloc(
        getNewsPopularityById: sl(),
        loadingNewsPopularityFromNetwork: sl(),
        setUserSeePage: sl()
    ),
  );

  /// app
  sl.registerFactory(() => AppBloc(),);

  /// video gallery
  sl.registerFactory(
        () => VideoGalleryBloc(
        getVideoGalleryFromNetwork: sl()
    ),
  );

  /// birthday
  sl.registerFactory(
        () => BirthdayBloc(
          repository: sl()
    ),
  );

  /// selected index
  sl.registerFactory(() => SelectedIndexBloc());

  /// response
  sl.registerFactory(() => ResponsesBloc());

  /// fields
  sl.registerFactory(() => FieldsBloc());


  ///! USE CASES

  /// news portal
  sl.registerLazySingleton(() => GetNewsPortalFormNetwork(sl()));
  sl.registerLazySingleton(() => GetNewsPortalFromCache(sl()));

  /// profile
  sl.registerLazySingleton(() => GetProfileFormNetwork(sl()));
  sl.registerLazySingleton(() => GetProfileFromCache(sl()));

  /// main params page
  sl.registerLazySingleton(() => GetMainParamsFromJson(sl()));
  sl.registerLazySingleton(() => SetMainParamsToJson(sl()));

  /// likes/seen
  sl.registerLazySingleton(() => LoadingNewsPopularityFromNetwork(sl()));
  sl.registerLazySingleton(() => GetNewsPopularityById(sl()));
  sl.registerLazySingleton(() => GetNewsPopularityUserFromJson(sl()));
  sl.registerLazySingleton(() => SetUserLikedPageToJson(sl()));
  sl.registerLazySingleton(() => SetUserSeePage(sl()));

  ///video gallery
  sl.registerLazySingleton(() => GetVideoGalleryFromNetwork(sl()));









  ///! REPOSITORY

  /// news portal
  sl.registerLazySingleton<INewsPortalRepository>(
        () => NewsPortalRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// profile
  sl.registerLazySingleton<IProfileRepository>(
        () => ProfileRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// main params page
  sl.registerLazySingleton<IMainParamsRepository>(
        () => MainParamsRepository(
      jsonDataSource: sl(),
    ),
  );

  /// likes/seen
  sl.registerLazySingleton<INewsPopularityRepository>(
        () => NewsPopularityRepository(
        networkInfo: sl(),
        remoteDataSource: sl()
    ),
  );

  /// video gallery
  sl.registerLazySingleton<IVideoGalleryRepository>(
        () => VideoGalleryRepository(
        networkInfo: sl(),
        remoteDataSource: sl()
    ),
  );

  /// birthday
  sl.registerLazySingleton<IBirthdayRepository>(
        () => BirthdayRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        errorCatcher: sl()
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
        () => NewsPortalLocalDataSource(sharedPreferences: sl()),
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
        () => MainParamsJsonDataSource(),
  );

  /// likes/seen
  sl.registerLazySingleton<NewsPopularityRemoteDataSource>(
        () => NewsPopularityRemoteDataSource(
        client: sl(),
        storage: sl()
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







  ///! CORE
  sl.registerLazySingleton<Storage>(() => Storage());
  sl.registerLazySingleton<ProfileParser>(() => ProfileParser());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ErrorCatcher>(() => ErrorCatcher(networkInfo: sl()));








  ///! EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}