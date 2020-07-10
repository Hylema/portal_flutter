import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/data/params/videoGallery/video_gallery_params.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;

abstract class IVideoGalleryRemoteDataSource {
  Future<List<VideosGalleryModel>> getVideos({@required VideoGalleryParams videoGalleryParams});
}

class VideoGalleryRemoteDataSource with ResponseHandler implements IVideoGalleryRemoteDataSource {
  Storage storage;
  final http.Client client;

  VideoGalleryRemoteDataSource({
    @required this.storage,
    @required this.client,
  });

  @override
  Future<List<VideosGalleryModel>> getVideos({
    @required VideoGalleryParams videoGalleryParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/videos', videoGalleryParams.toUrlParams()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<VideosGalleryModel>(response: response, model: VideosGalleryModel.fromJson, key: 'data');
  }
}