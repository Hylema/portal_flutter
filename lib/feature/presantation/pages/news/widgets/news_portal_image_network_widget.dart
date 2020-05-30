import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class ImageNetworkWidget extends StatelessWidget{

  ImageNetworkWidget({
    this.path,
    this.index,
  }){
    assert(path != null);
    assert(index != null);
  }
  final String path;
  final int index;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final Storage storage = getIt<Storage>();

    return Container(
      color: Colors.grey[100],
      child: Center(
          child: Hero(
            tag: 'imageNumber_$index',
            child: CachedNetworkImage(
              imageUrl: path,
              httpHeaders: {
                'Authorization': 'Bearer ${storage.token}'
              },
              fit: BoxFit.cover,
              height: 500,
              width: 1000,
              placeholder: (context, url) => Container(
                color: Colors.grey[100],
                child: Center(
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.grey[300],
                    size: 30,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[100],
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.grey[300],
                    size: 30,
                  ),
                ),
              ),
            ),
            transitionOnUserGestures: true,
          )
      ),
    );

  }
}
