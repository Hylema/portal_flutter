import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/datasources/videoGallery/video_gallery_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/videoGallery/video_gallery_repository_interface.dart';
import 'package:meta/meta.dart';

class VideoGalleryRepository implements IVideoGalleryRepository {
  final VideoGalleryRemoteDataSource remoteDataSource;
  //final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VideoGalleryRepository({
    @required this.remoteDataSource,
    //@required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, VideosGalleryModel>> getVideosFromNetwork(int pageIndex, int pageSize) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteVideos = await remoteDataSource.getVideos(pageIndex, pageSize);
        return Right(remoteVideos);
      } on AuthFailure {
        return Left(AuthFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch(e){
        return Left(UnknownErrorFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

//  @override
//  Future<Either<Failure, VideoGallery>> getVideosFromCache() async {
//    try {
//      final localNewsPortal = await localDataSource.getDataFromCache();
//      return Right(localNewsPortal);
//    } on CacheException {
//      return Left(CacheFailure());
//    }
//  }
}