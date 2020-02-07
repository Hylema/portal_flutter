import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/token/token.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
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
    final String token = Token.authToken;

    bool badImage = false;
    String file;
    String folder;
    String urlPath;

    folder = new RegExp("Shared[^]+\\/")
        .firstMatch(path)
        ?.group(0);
    if(folder == null) badImage = true;
    else folder = folder.substring(0, folder.length - 1);

    file = new RegExp("\\/(?:.(?!\\/))+\\?|\\/(?:.(?!\\/))+\$")
        .firstMatch(path)
        ?.group(0);
    if(file == null) badImage = true;
    else {
      String lastSymbol = file[file.length - 1];
      if(lastSymbol == '?') file = file.substring(1, file.length - 1);
      else file = file.substring(1);
    }

    urlPath = new RegExp("(.*)\\Shared")
        .firstMatch(path)
        ?.group(0);

    if(urlPath == null) badImage = true;
    else urlPath = urlPath.substring(0, urlPath.length - 7);

//    print('urlPath === $urlPath');
//    print('folder === $folder');
//    print('file === $file');

    if(badImage) return Image.asset('assets/images/metInvestIcon.png');


    return DownloadImage(
      imagePath: getImageUrl(folder, file, urlPath),
      index: index,
      token: token,
    );
  }
}

String getImageUrl(String folderName, String fileName, String urlPath){
  return "$urlPath/_api/web/GetFolderByServerRelativeUrl('$folderName')/Files('$fileName')/\$value";
}

class DownloadImage extends StatefulWidget {
  DownloadImage({this.imagePath, this.token, this.index}){
    assert(this.imagePath != null);
    assert(this.token != null);
    assert(this.index != null);
  }
  final String imagePath;
  final String token;
  final int index;

  @override
  State<StatefulWidget> createState() => DownloadImageState();
}
class DownloadImageState extends State<DownloadImage> {
  bool _checkLoaded = false;

  image(){
    try{
      return Image.network(
        '${widget.imagePath}',
        headers: {
          'Authorization': 'Bearer ${widget.token}'
        },
        fit: BoxFit.cover,
        height: 1000,
        width: 1000,
      );
    } on ServerException {
      return noImage();
    }
  }
  @override
  void initState() {
    super.initState();

    image().image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _){
      if(mounted){
        setState(() {
          _checkLoaded = true;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    if(this._checkLoaded == true){
      return Container(
        color: Colors.grey[100],
        child: Center(
            child: Hero(
              tag: 'imageNumber_${widget.index}',
              child: image(),
              transitionOnUserGestures: true,
            )
        ),
      );
    } else {
      return noImage();
    }
  }

  Widget noImage() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Icon(
          Icons.photo_camera,
          color: Colors.grey[300],
          size: 30,
        ),
      ),
    );
  }
}

