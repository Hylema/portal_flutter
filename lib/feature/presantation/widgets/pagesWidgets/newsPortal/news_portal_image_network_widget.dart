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
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkN0VHVoTUptRDVNN0RMZHpEMnYyeDNRS1NSWSIsImtpZCI6IkN0VHVoTUptRDVNN0RMZHpEMnYyeDNRS1NSWSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg4ODE5ODEzLCJuYmYiOjE1ODg4MTk4MTMsImV4cCI6MTU4ODgzMDkxMywiYWNyIjoiMSIsImFpbyI6IjQyZGdZSGovUFhWdjE3Mm9QWlpwc3dQbDE3UTFuVmNXRXVVUlRqTlByd3Q2cXZna2hoTUEiLCJhbXIiOlsicHdkIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImlkdHlwIjoidXNlciIsImlwYWRkciI6Ijc5LjExMS40Ni4xMDMiLCJuYW1lIjoi0KjQsNC70LDQudC60LjQvSDQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsIm9pZCI6IjA2Zjc4NDU4LThlODMtNDRiZi1hMGJmLWJmNmFjODM5Mjk3NyIsIm9ucHJlbV9zaWQiOiJTLTEtNS0yMS0yMDcwNTk3MTA5LTYzODAxMTU2OS0xODczNzY3OTAwLTE2NTQ2IiwicHVpZCI6IjEwMDMyMDAwNjc4OTk5NkMiLCJzY3AiOiJBbGxTaXRlcy5Xcml0ZSBNeUZpbGVzLlJlYWQgVGVybVN0b3JlLlJlYWQuQWxsIFVzZXIuUmVhZCBVc2VyLlJlYWQuQWxsIiwic2lkIjoiZjY0MmNhY2UtYTI1NC00ZmZkLTkwYWUtN2ZhODU0NTlkNDRjIiwic2lnbmluX3N0YXRlIjpbImttc2kiXSwic3ViIjoiaDdDcm90NmZrR2lDSF9DM09NME1zRXpVSEdKNW9xMF9Hel85MWJ2ZXk5WSIsInRpZCI6IjEyZjZhZDQ0LWQxYmEtNDEwZi05N2Q0LTZjOTY2ZTM4NDIxYiIsInVuaXF1ZV9uYW1lIjoiZy5zaGFsYWlraW5AanNhLWdyb3VwLnJ1IiwidXBuIjoiZy5zaGFsYWlraW5AanNhLWdyb3VwLnJ1IiwidXRpIjoiRi1CRFdYTFJBa21uU190V2dsUUdBQSIsInZlciI6IjEuMCJ9.e7ggzgU0gJVHMID6ZKrg-ubjSQ_j2yXInT66uMLJb7pEAvmHy7Z8UZh29nCgoacH-eE7fxcURyPj8iVVjLRftYg9n3UY2j7Ri8SQZDWoBuc5p562hl0SSzJMqJXZa3eazNUmwIdDmDJEUEWGrndxq1FjnEqeCLbPkl2AD6a9mhML4xM_fLFURoZBDnGxlVLogfnGsUL4lI8eZmwdLSCeEVNiDi9Y0z2URgm2wjI-j9pixGtup3hq-rwQoVLMkljVLAS3FAatp_QVX-r0qXCnMTDv4ou4Y-nFwgdINB4ViGagU3ivi1qRH1m2D9nL3bWFq_vkAstrKSk9kkP2bQoOAg'
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

