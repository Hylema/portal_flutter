import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/api/token/auth_token.dart';
import 'package:flutter_architecture_project/core/api/token/token.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
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
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {});

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (mounted) {
        RegExp regExp = new RegExp("code=(.*)\&");
        this.code = regExp.firstMatch(url)?.group(1);

//        var tokenClass = new AuthToken();
//        await tokenClass.writeFile('eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgxMDgwMjA2LCJuYmYiOjE1ODEwODAyMDYsImV4cCI6MTU4MTA5MTMwNiwiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQVllbk9DU2FvNHVXeCtDL0Q4WGw5ckpqS1ZaMXQzTjVrdW1TVnZOKzE2ckE9IiwiYW1yIjpbIndpYSJdLCJhcHBfZGlzcGxheW5hbWUiOiJNaS1wb3J0YWwtcmVnaXN0cmF0aW9uIiwiYXBwaWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJhcHBpZGFjciI6IjEiLCJmYW1pbHlfbmFtZSI6ItCo0LDQu9Cw0LnQutC40L0iLCJnaXZlbl9uYW1lIjoi0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJpcGFkZHIiOiIxODguMTcwLjIxNy45MCIsIm5hbWUiOiLQqNCw0LvQsNC50LrQuNC9INCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwib2lkIjoiMDZmNzg0NTgtOGU4My00NGJmLWEwYmYtYmY2YWM4MzkyOTc3Iiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTIwNzA1OTcxMDktNjM4MDExNTY5LTE4NzM3Njc5MDAtMTY1NDYiLCJwdWlkIjoiMTAwMzIwMDA2Nzg5OTk2QyIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzaWQiOiI3OTMwNmU2ZC0zMmJhLTQyZTYtODhlOC1kODQ0ZjFkMWY2MjYiLCJzdWIiOiJoN0Nyb3Q2ZmtHaUNIX0MzT00wTXNFelVIR0o1b3EwX0d6XzkxYnZleTlZIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiJYMHBiS3BiaHQwU2ZZVnVhenJsUkFBIiwidmVyIjoiMS4wIn0.NIJLsvDdiZO5ej4xiJEcLOXdIzVjvJahxHYQS1SOK51PXrc392Oeun-pwL-fFdKZsCnesD5Q5h69FAD5sEsNcHun5_niJj2Bta6drDZsYYtLrglV4fIjYenHvyWfKpsDvkQqbHq5RU0ANQbG9OAQbziz2HCT8SX-bvmIAYyo9Poe55X7ZKtatHZr4GHrXt9AwyPdQ2V_aiCvkwYvzyjbu9bpsivJmMK5jaK0mROIUo1uRWfB6RSZu2bkGvj_bEQVdk6BV6HB594_e8Bg6KRYuVbeMKU_6_7iz6uWg25yGGk7E30Sv9nd7xWWpXtPaLXMl1j58JjjQ6yTZMtnnkWWUQ');
//        Navigator.push(context, ScaleRoute(page: AppPage()));

        if(code != null){
          var tokenClass = new AuthToken();
          await tokenClass.getTokenFromNetwork(code);
          Navigator.push(context, ScaleRoute(page: AppPage()));
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