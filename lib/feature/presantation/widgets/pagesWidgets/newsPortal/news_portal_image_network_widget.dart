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
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0MDA5NzM4LCJuYmYiOjE1ODQwMDk3MzgsImV4cCI6MTU4NDAyMDgzOCwiYWNyIjoiMSIsImFpbyI6IjQyTmdZR0FSUHo5Qi82OU5xcWZYbkwrYkltUFpwL2NHS096b2ZMV2gwVkZqOG5FVm5UOEEiLCJhbXIiOlsid2lhIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInB1aWQiOiIxMDAzMjAwMDY3ODk5OTZDIiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInNpZCI6IjZmOWMxMDE0LTQ2MTctNGQyNy05NmE2LTFlNmU3NGMwZWI0YSIsInN1YiI6Img3Q3JvdDZma0dpQ0hfQzNPTTBNc0V6VUhHSjVvcTBfR3pfOTFidmV5OVkiLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6InRKU05tZDVrdlVpQlZpVFhRTHRtQUEiLCJ2ZXIiOiIxLjAifQ.aD49TzHq8gdWLOYrfB9Zgpd2PzXr1275jRbaxk0ojn5ZiMMYO4fIBoptYRSLHo44lQTtE1_8G3-78Vg6IrbKhRVJ84yysm19bPo3BZ5bot5mG7-UvS9Zq3sW6Jbw8z8DdWbarBMg9TynhwZh-XlXiRypWLOHKpWy0GUab2rsYndic5uqKVnMvFnKLhN0bDyrqX-Ou8icoCO_QfdGcUAYNBCePSDyEZp0SwB54aoGWSQgFsYTlNTI391WBePKasGNfAJS6D2V-Lc8kIyLgrE7urVfOajaKsmXRyZfjWL-21f0YZUwAnGE78yN2VlfRGtwJCgPiCRt0i5UW1KDU93mpA'
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

