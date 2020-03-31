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

        String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0Njg5MzkxLCJuYmYiOjE1ODQ2ODkzOTEsImV4cCI6MTU4NDcwMDQ5MSwiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQUl1cXpNcldTbDE2TXc2UDQ3RThvSGt0YXdLYnJ0WFB6N0pUTlRnVStHNlU9IiwiYW1yIjpbIndpYSJdLCJhcHBfZGlzcGxheW5hbWUiOiJNaS1wb3J0YWwtcmVnaXN0cmF0aW9uIiwiYXBwaWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJhcHBpZGFjciI6IjEiLCJmYW1pbHlfbmFtZSI6ItCo0LDQu9Cw0LnQutC40L0iLCJnaXZlbl9uYW1lIjoi0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJpbl9jb3JwIjoidHJ1ZSIsImlwYWRkciI6IjE4OC40My4xLjEwMSIsIm5hbWUiOiLQqNCw0LvQsNC50LrQuNC9INCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwib2lkIjoiMDZmNzg0NTgtOGU4My00NGJmLWEwYmYtYmY2YWM4MzkyOTc3Iiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTIwNzA1OTcxMDktNjM4MDExNTY5LTE4NzM3Njc5MDAtMTY1NDYiLCJwdWlkIjoiMTAwMzIwMDA2Nzg5OTk2QyIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzaWQiOiJiMmM1NDRiMi0yODFjLTRhYzAtOTNiNC04YzI4MTg4ZTJjZDIiLCJzdWIiOiJoN0Nyb3Q2ZmtHaUNIX0MzT00wTXNFelVIR0o1b3EwX0d6XzkxYnZleTlZIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiJwNE5mZlRtbkZVT2VuYVRhZHJSNEFBIiwidmVyIjoiMS4wIn0.m32l5JJIdUYcTwzwMvGAhHMmmTRcHYZSOc3_-5rMFsz7P2-IlqiZO6lO2Z1eNta8TcAWS2DyQ002U8TYHvhR9UElh9cBnQwifZjjagWdAM-1Ix3fW-kek6bBkm_FRvBuwwpIYjhOkWUyguNxsafXrI8__VfcOWpmWZr1ag5KmzympHTWwwmu5w5JkS-HAmr05m08p83GlF4fVpwdAcNFq_oHhZA2dhpi9ei4QDdVCfga3wQVkHIfxvlKDsLhn_NkUOZ8xpFQbxE4iOXbsdoQsPd2t9AkM5Dm-wS2AB6q8n5AbDeOgxfZdC0RODGnpbov-9q4ldL5KyThj5UqG9nv3g';
        String secondToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0Njg5NDE4LCJuYmYiOjE1ODQ2ODk0MTgsImV4cCI6MTU4NDcwMDUxOCwiYWNyIjoiMSIsImFpbyI6IjQyTmdZTEFMYmUxL0szMmpNYUpmemlGaHlaZUVLUjFGZnhiSlNnUzBaM0NtOHIrUitBQUEiLCJhbXIiOlsid2lhIl0sImFwcGlkIjoiMGNmM2YxNzctNmQzMi00NDBjLWE0ZTItMDhjYzg0ZGJjM2JiIiwiYXBwaWRhY3IiOiIxIiwiZmFtaWx5X25hbWUiOiLQqNCw0LvQsNC50LrQuNC9IiwiZ2l2ZW5fbmFtZSI6ItCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwiaW5fY29ycCI6InRydWUiLCJpcGFkZHIiOiIxODguNDMuMS4xMDEiLCJuYW1lIjoi0KjQsNC70LDQudC60LjQvSDQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsIm9pZCI6IjA2Zjc4NDU4LThlODMtNDRiZi1hMGJmLWJmNmFjODM5Mjk3NyIsIm9ucHJlbV9zaWQiOiJTLTEtNS0yMS0yMDcwNTk3MTA5LTYzODAxMTU2OS0xODczNzY3OTAwLTE2NTQ2Iiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInN1YiI6Ik9rMl9VakxVNkhJdnpJMmN5aVRjeV8tZ2g5S3N2RmE2SVk5RkYtSzNNMW8iLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6IjNOQ2VhRHR6WWtlQWROV3V4M0Y1QUEiLCJ2ZXIiOiIxLjAifQ.S6dRXw5Ln_5wyVAl5r0hNG5zMfJ_IRLojEU5OW8xiW4s2BvV5ECrDdYDzpXVikAARju9TR6HQNaHy_DzllJ-PCU9a8yiVTNLmBKH4ujgQ03b05_zN9qPK92wiXZlG1BjSMl1JblRG83V8C7Y3n6cPapqhLe8TKemSglUCM3QEu-jOpV1dWX2qtDboCqrMwAQ-fFD8O_MduEC0l66UnwO2kbjAhTAqohSfSH8hzn7SetGrTeOchnibkZW_JwPIBEdnKIC65toU3CokmLH-hfys928axX2xNqF-sqXxqduC57NYgjyANI1wyEE6RC62dsOMOVD4xWiV0g6vvmxuyNElw';


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
       if(state is AuthCompletedState) {
         Navigator.pop(context);
       }
      },
      child: WebviewScaffold(
          url: Api.AUTH_URL,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text("Авторизация"),
            backgroundColor: Colors.red[800],
          ),
        withLocalStorage: true,
        withZoom: true,
      ),
    );
  }
}