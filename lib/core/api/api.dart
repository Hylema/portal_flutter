import 'package:flutter/material.dart';

class Api {
  static const String AUTH_URL = 'https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/authorize?response_type=code&client_id=0cf3f177-6d32-440c-a4e2-08cc84dbc3bb&redirect_uri=https://mi-portal.azurewebsites.net&%D1%8client_secret=OLijLFc8Syld34P6%5BpAOJJIT%5B%5BRrMUM-&resource=https://metalloinvest.sharepoint.com';
  static const String GET_TOKEN_URL = 'https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/token';
  static const String GET_PROFILE_URL = "https://metalloinvest.sharepoint.com/sites/portal/oemk/_api//SP.UserProfiles.PeopleManager/GetMyProperties";
  static const String HOST_URL = "mi-portal-mobile.westeurope.cloudapp.azure.com:8080";
  static const String NEWS_URL = "mi-portal-mobile.westeurope.cloudapp.azure.com:8080";
  //static const String HOST_URL = "http://mi-portal-mobile.westeurope.cloudapp.azure.com:8080";
}

//Scaffold.of(context).showSnackBar(SnackBar(context: Text('test')));