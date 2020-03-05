import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;
abstract class IVideoGalleryRemoteDataSource {
  
  Future<VideosGalleryModel> getVideos(int pageIndex, int pageSize);
}

class VideoGalleryRemoteDataSource implements IVideoGalleryRemoteDataSource {
  final http.Client client;
  Storage storage;

  VideoGalleryRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  @override
  Future<VideosGalleryModel> getVideos(int pageIndex, int pageSize) =>
      _getVideosFromUrl('${Api.HOST_URL}:8080/api/videos?pageSize=$pageSize&pageIndex=$pageIndex');

  Future<VideosGalleryModel> _getVideosFromUrl(String url) async {

    final response = await client.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    if (response.statusCode == 200) {
      return VideosGalleryModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else if(response.statusCode == 401){
      throw AuthFailure();
    } else {
      throw ServerException();
    }
  }
}