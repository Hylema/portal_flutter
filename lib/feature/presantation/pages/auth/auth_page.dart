import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class AuthPage extends StatefulWidget {

  @override
  AuthPagebState createState() => new AuthPagebState();
}

class AuthPagebState extends State<AuthPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String code;

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          //print("onStateChanged: ${state.type} ${state.url}");

//          print('URL ===========================================================${state.url}');
//          RegExp regExp = new RegExp("code=(.*)\&");
//          this.code = regExp.firstMatch(state.url)?.group(1);
//
//          print("code $code");
//
//          if(code != null){
//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(codeUrl: code)));
//            flutterWebviewPlugin.close();
//          };
        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        //print('URL ===========================================================${url}');
        RegExp regExp = new RegExp("code=(.*)\&");
        this.code = regExp.firstMatch(url)?.group(1);

        print("code $code");

        if(code != null){
          //Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => MyHomePage()));
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: Api.AUTH_URL,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Авторизация"),
          backgroundColor: Colors.red[800],
        )
    );
  }
}