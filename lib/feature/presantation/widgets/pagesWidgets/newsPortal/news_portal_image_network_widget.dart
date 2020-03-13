import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    );
  }
}

String getImageUrl(String folderName, String fileName, String urlPath){
  return "$urlPath/_api/web/GetFolderByServerRelativeUrl('$folderName')/Files('$fileName')/\$value";
}

class DownloadImage extends StatefulWidget {
  DownloadImage({this.imagePath, this.index}){
    assert(this.imagePath != null);
    assert(this.index != null);
  }
  final String imagePath;
  final int index;

  @override
  State<StatefulWidget> createState() => DownloadImageState();
}
class DownloadImageState extends State<DownloadImage> {
  bool _checkLoaded = false;

  image() {
//    final storage = new FlutterSecureStorage();
//    String token = await storage.read(key: 'token');

    try{
      return Image.network(
        '${widget.imagePath}',
        headers: {
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0MDk2MDYxLCJuYmYiOjE1ODQwOTYwNjEsImV4cCI6MTU4NDEwNzE2MSwiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQUJuazVhRkZjcEpXZ2p5U2JyZXNDbUpwNG1qdlFsYWc1TURvdjArZ2ZFdm89IiwiYW1yIjpbIndpYSJdLCJhcHBfZGlzcGxheW5hbWUiOiJNaS1wb3J0YWwtcmVnaXN0cmF0aW9uIiwiYXBwaWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJhcHBpZGFjciI6IjEiLCJmYW1pbHlfbmFtZSI6ItCo0LDQu9Cw0LnQutC40L0iLCJnaXZlbl9uYW1lIjoi0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJpbl9jb3JwIjoidHJ1ZSIsImlwYWRkciI6IjE4OC40My4xLjEwMSIsIm5hbWUiOiLQqNCw0LvQsNC50LrQuNC9INCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwib2lkIjoiMDZmNzg0NTgtOGU4My00NGJmLWEwYmYtYmY2YWM4MzkyOTc3Iiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTIwNzA1OTcxMDktNjM4MDExNTY5LTE4NzM3Njc5MDAtMTY1NDYiLCJwdWlkIjoiMTAwMzIwMDA2Nzg5OTk2QyIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzaWQiOiI2ZjljMTAxNC00NjE3LTRkMjctOTZhNi0xZTZlNzRjMGViNGEiLCJzdWIiOiJoN0Nyb3Q2ZmtHaUNIX0MzT00wTXNFelVIR0o1b3EwX0d6XzkxYnZleTlZIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiI1a2tFc2FvTHlVZWI2MjlkSEdXdEFBIiwidmVyIjoiMS4wIn0.PZ_5-KlwD-qP9JD_nDcUCdG3vPcfJPtpbChNksP8QiSNwTsM5PXXxMJ6jz8rKzCVmtsOHAKKY7JLjy5_XPoOnyPy26WhOD845PbvP5xrGXRwNOVvLDd38_P48oU5MMFQBgso1XQdlVer3U9ovNNK-Yr8w0ae8TMlYWjNwYyvsOdlj8Zn6emgzoAiBON95W6Xq9hZyKoDaNt10XtWd_9lCrTr3y1HLJ8nHSxyhNNygTarCkzEouRGKCgNInXLUd_RjVMZXP1Y418PvGrnvPSBpK2kQRPn-MWi_RlIPzft8hBRoJfJ9QGLX5SkNboachYNMsdP32RlkKvcvEdHlbpGzg'
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

