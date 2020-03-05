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

        String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgzMzg5NjA0LCJuYmYiOjE1ODMzODk2MDQsImV4cCI6MTU4MzQwMDcwNCwiYWNyIjoiMSIsImFpbyI6IjQyTmdZQ2dRdXh4ZU9PRmEyaTIrTGVFZHgyWi9TSE01dDgzWWFYRjlUMG5PdVVYekRFMEIiLCJhbXIiOlsid2lhIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInB1aWQiOiIxMDAzMjAwMDY3ODk5OTZDIiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInNpZCI6ImI3ZDg3NzNkLTk5MGMtNDVjMy05ZjIzLTE0ZTFhNTU3ZGMwZCIsInN1YiI6Img3Q3JvdDZma0dpQ0hfQzNPTTBNc0V6VUhHSjVvcTBfR3pfOTFidmV5OVkiLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6IkF6blZTNE5adDBhNXRiMEVfb2NJQUEiLCJ2ZXIiOiIxLjAifQ.TCPL1K56s90WpGMf5x-d0u-Z27SMpyrQYP7iWTsFBG39q0Ue4VY8ohmTOtT-K9AO8QrzjIVr_YebSYsn8Z8ET8Z4YhUdAOAHj4wXJtaz1gb0inzTVpX17lEDc-fENw_vGycBziQcVlGRfs_NbGLjFBxE7bVeKzZg_IdyyZHHkQEfKvy3TKDnQzaMEDUylkp9DztyB6ZpUV95FB3bPeBCtCbO85xuE5yYHa9NQrpe3X6d_eiTRpGJ6fcxHSsJZX0_ghx420SVk_OgBmuRt2VXIPBJbTgGb2ZJ1cmEuGvUojNv_TzTvP2K_JhfM1kHdvGi8XL16vajkxlqcK66jyDMng';
        String secondToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiIwY2YzZjE3Ny02ZDMyLTQ0MGMtYTRlMi0wOGNjODRkYmMzYmIiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgzMzg5Njg2LCJuYmYiOjE1ODMzODk2ODYsImV4cCI6MTU4MzQwMDc4NiwiYWNyIjoiMSIsImFpbyI6IjQyTmdZRkNiTDNQZ1ltRzhqSW1ENVV6M28vM1h5LzJ5VmtrOWoyV2Y4ZUNOM0s0TDA0d0IiLCJhbXIiOlsid2lhIl0sImFwcGlkIjoiMGNmM2YxNzctNmQzMi00NDBjLWE0ZTItMDhjYzg0ZGJjM2JiIiwiYXBwaWRhY3IiOiIxIiwiZmFtaWx5X25hbWUiOiLQqNCw0LvQsNC50LrQuNC9IiwiZ2l2ZW5fbmFtZSI6ItCT0LvQtdCxINCd0LjQutC-0LvQsNC10LLQuNGHIiwiaW5fY29ycCI6InRydWUiLCJpcGFkZHIiOiIxODguNDMuMS4xMDEiLCJuYW1lIjoi0KjQsNC70LDQudC60LjQvSDQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsIm9pZCI6IjA2Zjc4NDU4LThlODMtNDRiZi1hMGJmLWJmNmFjODM5Mjk3NyIsIm9ucHJlbV9zaWQiOiJTLTEtNS0yMS0yMDcwNTk3MTA5LTYzODAxMTU2OS0xODczNzY3OTAwLTE2NTQ2Iiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInN1YiI6Ik9rMl9VakxVNkhJdnpJMmN5aVRjeV8tZ2g5S3N2RmE2SVk5RkYtSzNNMW8iLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6Im9NSFFvRG1oN2tTWFh5RU9lRGdKQUEiLCJ2ZXIiOiIxLjAifQ.uX_BqnD7VNXNVWipfaNmoxccMT093FlT21KDD-5klZ3G9s3aPeWsxl-3GIfzWrsNobnPj9Nvya1VTas_qmle78JEi-IUrYwEHBBYAw9rWK7W2bl1iLu0valFELoXuyQMSMd1neIHa4KqkXnGlufvthhlhY_rA5EEvmKXmmf4_UslY11NjFiflMLea9LhFLOBI4E-l-pB56c9SXU1Ev5B6SGCFJcM75OhHyQy9NKpgYg2YcoXc6C6IG2jlIvK21ETgcm__Syq0YDt92NQsJzNXS8kiY_hCVzIUg2ha6YJZln84t2mbdSjqakrQ638luwfyEC9ZirF6ywrh_Y7lRI7_Q';

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