import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:page_transition/page_transition.dart';


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
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {});

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (mounted) {
        RegExp regExp = new RegExp("code=(.*)\&");
        this.code = regExp.firstMatch(url)?.group(1);

        String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgyODA2MzEyLCJuYmYiOjE1ODI4MDYzMTIsImV4cCI6MTU4MjgxNzQxMiwiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQW1TY005WXZieThLem9ESXBJdHJ4NWZZTTVuVUFlOUZkY1hESkN5VVZnSmM9IiwiYW1yIjpbIndpYSJdLCJhcHBfZGlzcGxheW5hbWUiOiJNaS1wb3J0YWwtcmVnaXN0cmF0aW9uIiwiYXBwaWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJhcHBpZGFjciI6IjEiLCJmYW1pbHlfbmFtZSI6ItCo0LDQu9Cw0LnQutC40L0iLCJnaXZlbl9uYW1lIjoi0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJpbl9jb3JwIjoidHJ1ZSIsImlwYWRkciI6IjE4OC40My4xLjEwMSIsIm5hbWUiOiLQqNCw0LvQsNC50LrQuNC9INCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwib2lkIjoiMDZmNzg0NTgtOGU4My00NGJmLWEwYmYtYmY2YWM4MzkyOTc3Iiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTIwNzA1OTcxMDktNjM4MDExNTY5LTE4NzM3Njc5MDAtMTY1NDYiLCJwdWlkIjoiMTAwMzIwMDA2Nzg5OTk2QyIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzaWQiOiIxMmE3OWI2Zi0xYjJlLTQ0MzAtOTcwNy02ZmMyMDEyOGExZTEiLCJzdWIiOiJoN0Nyb3Q2ZmtHaUNIX0MzT00wTXNFelVIR0o1b3EwX0d6XzkxYnZleTlZIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiI4MzQ3M2VrSnJVNklkTHNSeTlFaUFBIiwidmVyIjoiMS4wIn0.dlsteSE5DjkUxr0__uvTxzO-7iBd4FzsWW9luvtnurxXifEQ3tQn0Mk79knplkVOlOBDQtdp19fxqzrmXl7CWcTv7NUEvP7o2amuBgDJ-SgLvclWTFlQRDmJgTSy-SOBFhPpC5ly1M0x_mVI5-lJAByUkrsYZOIuVGDXzMApEQcHLb-l79gMzgZKdodMK792qxTPPGgWX43gW-u5pBHbD25wvRJj0jpJmmRroyO5QmHLLysY46GjyNNmUde_dTThApcrOWRJYnGpQ7FoLvhRbW48z7DeYk0vyqE-Fl-jB3M94eLUC22RrGZ0a3fbAuIR-1FlbOkM_8BCTQaHQOPBFQ';
        String secondToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgyODA2MzQ3LCJuYmYiOjE1ODI4MDYzNDcsImV4cCI6MTU4MjgxNzQ0NywiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQVhLQTE2RTVJdkdoVVB2cWZBTFczSGxITXRJOEZabDNXZ0xpaXNEWHZsQlk9IiwiYW1yIjpbIndpYSJdLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzdWIiOiJPazJfVWpMVTZISXZ6STJjeWlUY3lfLWdoOUtzdkZhNklZOUZGLUszTTFvIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiJIZ2VZcGp1MGxVbV9ZaTlWejlrZ0FBIiwidmVyIjoiMS4wIn0.hp30AdqBEUTlI1LRGcExC6fjJSvZx6sT67HDAK4NcxpuIPuK4i03QuuM_GJmPw71II4clVS64A1JJ5HXgP8nBgp9CCc8aQg94h_VIQYZ4-jyd4RqPqMGPH0f-G-CTOlpe3PM8oDyCoByqi0omV3awsYO-4Qcz3vISER6nD-iZGy6_YPIOtdzFEh_zVwb8OmIoatXgYzQQwxpWmLNNMw6wHvGz8H8PFEbvaO0qi7xI5g84gR6jK7AziiSMjUPBGQexaKmQj1QKkFJwMKRzIVZrcmfuxwUcv7AQVaxvGcHEzHm3I9Zy1aUrucCSVkKJFNjQvqrhnsuUyORhOHMPbc-bw';

        final storage = new FlutterSecureStorage();
        await storage.write(key: JWT_TOKEN, value: token);
        await storage.write(key: JWT_DECODE, value: jsonEncode(Jwt.parseJwt(token)));
        await storage.write(key: JWT_TOKEN_SECOND, value: secondToken);

//        if(code != null){
//          Navigator.push(context, ScaleRoute(page: WelcomePage()));
//        };
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