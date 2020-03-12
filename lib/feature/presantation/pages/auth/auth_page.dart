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

        String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0MDA5NzM4LCJuYmYiOjE1ODQwMDk3MzgsImV4cCI6MTU4NDAyMDgzOCwiYWNyIjoiMSIsImFpbyI6IjQyTmdZR0FSUHo5Qi82OU5xcWZYbkwrYkltUFpwL2NHS096b2ZMV2gwVkZqOG5FVm5UOEEiLCJhbXIiOlsid2lhIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInB1aWQiOiIxMDAzMjAwMDY3ODk5OTZDIiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInNpZCI6IjZmOWMxMDE0LTQ2MTctNGQyNy05NmE2LTFlNmU3NGMwZWI0YSIsInN1YiI6Img3Q3JvdDZma0dpQ0hfQzNPTTBNc0V6VUhHSjVvcTBfR3pfOTFidmV5OVkiLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6InRKU05tZDVrdlVpQlZpVFhRTHRtQUEiLCJ2ZXIiOiIxLjAifQ.aD49TzHq8gdWLOYrfB9Zgpd2PzXr1275jRbaxk0ojn5ZiMMYO4fIBoptYRSLHo44lQTtE1_8G3-78Vg6IrbKhRVJ84yysm19bPo3BZ5bot5mG7-UvS9Zq3sW6Jbw8z8DdWbarBMg9TynhwZh-XlXiRypWLOHKpWy0GUab2rsYndic5uqKVnMvFnKLhN0bDyrqX-Ou8icoCO_QfdGcUAYNBCePSDyEZp0SwB54aoGWSQgFsYTlNTI391WBePKasGNfAJS6D2V-Lc8kIyLgrE7urVfOajaKsmXRyZfjWL-21f0YZUwAnGE78yN2VlfRGtwJCgPiCRt0i5UW1KDU93mpA';
        String secondToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSIsImtpZCI6IllNRUxIVDBndmIwbXhvU0RvWWZvbWpxZmpZVSJ9.eyJhdWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTg0MDA5ODM3LCJuYmYiOjE1ODQwMDk4MzcsImV4cCI6MTU4NDAyMDkzNywiYWNyIjoiMSIsImFpbyI6IkFTUUEyLzhPQUFBQXFNNDBseEFXT1FkSmgvbmcrL0E5dzE2UXkxL1ZuWW9iM2ZoN2JsWVBvNTQ9IiwiYW1yIjpbIndpYSJdLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInNjcCI6IkFsbFNpdGVzLldyaXRlIE15RmlsZXMuUmVhZCBUZXJtU3RvcmUuUmVhZC5BbGwgVXNlci5SZWFkIFVzZXIuUmVhZC5BbGwiLCJzdWIiOiJPazJfVWpMVTZISXZ6STJjeWlUY3lfLWdoOUtzdkZhNklZOUZGLUszTTFvIiwidGlkIjoiMTJmNmFkNDQtZDFiYS00MTBmLTk3ZDQtNmM5NjZlMzg0MjFiIiwidW5pcXVlX25hbWUiOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1cG4iOiJnLnNoYWxhaWtpbkBqc2EtZ3JvdXAucnUiLCJ1dGkiOiJkRHh6U3ZpQ3kwcXRLbVg4cXlwc0FBIiwidmVyIjoiMS4wIn0.U23_8Nu9Dcc0gAjTmrxtdRwdR6x0Yn9mgLI5jUuxExm5fBeyzGPN5BE0kXocSrlvUXBNKLTkyF4sRYuIswCF8GB8delhsYkWQT7xg0BIzwq9jVDhCewLImSmu1yHNAMUkwlckYbuUBSb6Gx35sHxFj2ITuG9mObXrkr3-7AxWj3d5BfHGjTcRVSqZo5OSU6bjGemWgqbcDOsWUX_DgUz7JSel3O4RXxiGh5xaAHlmO0MQFfFC9qbo6U4hlIV_8v5mXlgzsyccFjJpQty0SBXMCjmLvZu7x3KzFSNcsjTKnGvNOMhqL5WArjotjhulljIkihOjxumJTZK2eQVTM8zXA';

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