import 'package:flutter_architecture_project/feature/data/datasources/videoGallery/video_gallery_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/videoGallery/video_gallery_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/videoGallery/video_gallery_repository_interface.dart';
import 'package:meta/meta.dart';

class VideoGalleryRepository implements IVideoGalleryRepository{
  final VideoGalleryRemoteDataSource remoteDataSource;
  //final VideoGalleryLocalDataSource localDataSource;

  VideoGalleryRepository({
    @required this.remoteDataSource,
    //@required this.localDataSource,
  });

  @override
  Future<List<VideosGalleryModel>> fetchVideos({VideoGalleryParams params}) async {
    List<VideosGalleryModel> listModel =
    await remoteDataSource.getVideos(videoGalleryParams: params);

    ///save

    return listModel;
  }

  @override
  Future<List<VideosGalleryModel>> updateVideos({VideoGalleryParams params}) async {
    List<VideosGalleryModel> listModel =
    await remoteDataSource.getVideos(videoGalleryParams: params);

    ///update

    return listModel;
  }
}