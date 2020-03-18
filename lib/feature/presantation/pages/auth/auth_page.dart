import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  var authBloc;

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
    authBloc = BlocProvider.of<AuthBloc>(context);
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
        code = regExp.firstMatch(url)?.group(1);
        if(code != null) authBloc.add(AuthCodeEvent(code: code));

        String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0NTMwMTQ5LCJuYmYiOjE1ODQ1MzAxNDksImV4cCI6MTU4NDU0MTI0OSwiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQUlHMW8yN0ZtaWEyK3Z6endhcHN0YjkvbHh3SFltcG45MldDclVyY2s5bGM9IiwiYW1yIjpbIndpYSJdLCJhcHBfZGlzcGxheW5hbWUiOiJNaS1wb3J0YWwtcmVnaXN0cmF0aW9uIiwiYXBwaWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJhcHBpZGFjciI6IjEiLCJmYW1pbHlfbmFtZSI6ItCo0LDQu9Cw0LnQutC40L0iLCJnaXZlbl9uYW1lIjoi0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJpbl9jb3JwIjoidHJ1ZSIsImlwYWRkciI6IjE4OC40My4xLjEwMSIsIm5hbWUiOiLQqNCw0LvQsNC50LrQuNC9INCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwib2lkIjoiMDZmNzg0NTgtOGU4My00NGJmLWEwYmYtYmY2YWM4MzkyOTc3Iiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTIwNzA1OTcxMDktNjM4MDExNTY5LTE4NzM3Njc5MDAtMTY1NDYiLCJwdWlkIjoiMTAwMzIwMDA2Nzg5OTk2QyIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzaWQiOiI0ZmNkZGZlNC1lMmQ2LTQ0ZWItYmE5MS1mZWY0YTU3ZTQwOWMiLCJzdWIiOiJoN0Nyb3Q2ZmtHaUNIX0MzT00wTXNFelVIR0o1b3EwX0d6XzkxYnZleTlZIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiJvYlRCQXJjZWRFbXBDc3RnYXhzYUFBIiwidmVyIjoiMS4wIn0.kBQ1SYwdlSQCKxbu7Laqt19BoqefbjAHvUoW0WL4wdYbycJHwiEz-Ig7CCQx-8-05r1m6Qc_t8LTxXi5-9IEpX4S_wwMhA7_CpmlbYkWuAiWa-7q2P5YOW2FTrElDb9qPH59G6xAuSuNhC2h0FS6QYY2rtwBcKkDhwCWQA-uCwibEx6JBVgLNQiB-JLMBYgeUcUnv9CtL6xNO0k7Fw7SbZl0x9YKbU78BCcZPgnCnXHUt-g6_BtL2kLxtOcYWYgVjqSMdwcURF4k8cAJtqC1c5yQCzoLDhYwo4tqfvw8csptukTOP2Tz6eI8D_vlDPnBi_q8tKccBvtzH7zUGeW71g';
        String secondToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0NTMwMTc4LCJuYmYiOjE1ODQ1MzAxNzgsImV4cCI6MTU4NDU0MTI3OCwiYWNyIjoiMSIsImFpbyI6IjQyTmdZQ2gzOGpwMEp2NUZ5a3R4SmJrODM0cE5ibFBlM0ZFUVphdHhlUEx1eFptd0taTUEiLCJhbXIiOlsid2lhIl0sImFwcGlkIjoiMGNmM2YxNzctNmQzMi00NDBjLWE0ZTItMDhjYzg0ZGJjM2JiIiwiYXBwaWRhY3IiOiIxIiwiZmFtaWx5X25hbWUiOiLQqNCw0LvQsNC50LrQuNC9IiwiZ2l2ZW5fbmFtZSI6ItCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwiaW5fY29ycCI6InRydWUiLCJpcGFkZHIiOiIxODguNDMuMS4xMDEiLCJuYW1lIjoi0KjQsNC70LDQudC60LjQvSDQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsIm9pZCI6IjA2Zjc4NDU4LThlODMtNDRiZi1hMGJmLWJmNmFjODM5Mjk3NyIsIm9ucHJlbV9zaWQiOiJTLTEtNS0yMS0yMDcwNTk3MTA5LTYzODAxMTU2OS0xODczNzY3OTAwLTE2NTQ2Iiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInN1YiI6Ik9rMl9VakxVNkhJdnpJMmN5aVRjeV8tZ2g5S3N2RmE2SVk5RkYtSzNNMW8iLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6ImJfNGJkcUdoQjAyRGRoa0xHandhQUEiLCJ2ZXIiOiIxLjAifQ.WeFOYUIoNSy7E_8kFO8TEVeeFyyFaYc0NmLP1p9aWOPndPA7jy21t6Qg857pkLog1OBQiRnp7LLl9rhPLNJwMBr-Jb1DuNdfs028PYOfqjmscZPJXjMC2hswKEtc9PCL_k67MIM0mNpG3catep87lUK4GhZUjjDIjAbnRisDeBNMwmqClJiQFZw8L30Q4MZGmgcJTPqq-Nx4c4CHZlE7p6i9myJJOI8S0_HRUCIw93Y5FkYQcEzrbiKe59qK7WPl0UUgSwyGhrSeArDGy0HCWHAKmBl7_NG9i5lxyC7tGHJkSZSJ8uCKTtw9-h7eGOUl219xCcIMAmU9FsZIqJ7JlA';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
       if(state is AuthCompletedState) {
         Navigator.pushNamed(context, '/welcome');
       }
      },
      child: WebviewScaffold(
          url: Api.AUTH_URL,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text("Авторизация"),
            backgroundColor: Colors.red[800],
          )
      ),
    );
  }
}