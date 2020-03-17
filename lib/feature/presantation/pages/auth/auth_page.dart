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

        String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0MzU4NjMzLCJuYmYiOjE1ODQzNTg2MzMsImV4cCI6MTU4NDM2OTczMywiYWNyIjoiMSIsImFpbyI6IjQyTmdZT0FJeTVKMGVNeWR1SEVSeHg1TGlmSUY4OStYeG1jeXY5b3NYY1p3YTdIenBnY0EiLCJhbXIiOlsid2lhIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInB1aWQiOiIxMDAzMjAwMDY3ODk5OTZDIiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInNpZCI6ImZlY2E3MWYyLTBjMGYtNDc2Ni1iYTFhLWU3NjQwMWRhZGMxOSIsInN1YiI6Img3Q3JvdDZma0dpQ0hfQzNPTTBNc0V6VUhHSjVvcTBfR3pfOTFidmV5OVkiLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6Im9MZjFXMDBZWWtxRHZBcW04LUVqQVEiLCJ2ZXIiOiIxLjAifQ.MOKU_K8xjn4JGqi_bb4SG1IwTb9u6HfOnSRG-Oe2nYoHkmiveb63K-TmxzdMly_B6YINtOW6uMf9ZBg8PFZi9qhs0D1RItYelKWQlFyMRc6JS57bJJpzNTp6jqJFJHv6duoT3z4vPxWMPm5O2OEmvkgIJdJQZdUmC6fbvFI9_C3IO_OdYLzvoua25i3Qlmc3UXLj1BMa7AJduy2vC9PpB__Lat4zxjamc8kDGsZAgIpnwTGe2tTh2DHbaXF9tR_3LkG1FXfKvTt5wi-3R-uosaePpQwCeyPDwOU1luvLCkupocwf-mqJ5ORKepbdsUHxtKgGrTVMXYxPL248FOlPZQ';
        String secondToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0MzU4NjY5LCJuYmYiOjE1ODQzNTg2NjksImV4cCI6MTU4NDM2OTc2OSwiYWNyIjoiMSIsImFpbyI6IjQyTmdZRkIxNDJCMzNadThuMFBLeTZMaHhvNFZuNEl2TnlaZDVOR0lVSTdKMStqMFNnUUEiLCJhbXIiOlsid2lhIl0sImFwcGlkIjoiMGNmM2YxNzctNmQzMi00NDBjLWE0ZTItMDhjYzg0ZGJjM2JiIiwiYXBwaWRhY3IiOiIxIiwiZmFtaWx5X25hbWUiOiLQqNCw0LvQsNC50LrQuNC9IiwiZ2l2ZW5fbmFtZSI6ItCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwiaW5fY29ycCI6InRydWUiLCJpcGFkZHIiOiIxODguNDMuMS4xMDEiLCJuYW1lIjoi0KjQsNC70LDQudC60LjQvSDQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsIm9pZCI6IjA2Zjc4NDU4LThlODMtNDRiZi1hMGJmLWJmNmFjODM5Mjk3NyIsIm9ucHJlbV9zaWQiOiJTLTEtNS0yMS0yMDcwNTk3MTA5LTYzODAxMTU2OS0xODczNzY3OTAwLTE2NTQ2Iiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInN1YiI6Ik9rMl9VakxVNkhJdnpJMmN5aVRjeV8tZ2g5S3N2RmE2SVk5RkYtSzNNMW8iLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6Ik51SWFrTXlaNUVXWE56bEZUekU1QVEiLCJ2ZXIiOiIxLjAifQ.lnOMQEM3n0xw20natUsrmKj6fCUjG4CK4xjo8z5yecNZbmnXBFTkfYtxwpNwCcTwJi7U5tr3DlQ3HnD7aZXrujahDV2ooFnI94eytFGx82fc9ukhw-RAySTJGjlDuHVuFUeQeM-yupWsHrxh3NisrA7p-5ZuT_Vp0V8X29xbjD03yy6m-rEAjqqceHJEZ4legteCIsCGYUhDyigJWVaIhMYVFAYf3oG28yzVSd5wcYGlZJsgX6_VtS0q_v-7ZRiBsTYSMGhoIcIUE5SJdV213BmfVNEGvZmS0VwZMaDiBBLn3m_P-Hj-f0PbXNG8dhNGHbWjfghBVveUzFpgsEwoeQ';

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
      );,
    );
  }
}