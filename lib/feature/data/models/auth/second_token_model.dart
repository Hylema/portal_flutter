import 'package:meta/meta.dart';

class SecondTokenModel {
  final String tokenType;
  final String scope;
  final String expiresIn;
  final String extExpiresIn;
  final String expiresOn;
  final String notBefore;
  final String resource;
  final String accessToken;
  final String refreshToken;

  SecondTokenModel({
    @required this.tokenType,
    @required this.scope,
    @required this.expiresIn,
    @required this.extExpiresIn,
    @required this.expiresOn,
    @required this.notBefore,
    @required this.resource,
    @required this.accessToken,
    @required this.refreshToken,
  });

  static SecondTokenModel fromJson(raw){
    return SecondTokenModel(
      tokenType: raw['token_type'],
      scope: raw['scope'],
      expiresIn: raw['expires_in'],
      extExpiresIn: raw['ext_expires_in'],
      expiresOn: raw['expires_on'],
      notBefore: raw['not_before'],
      resource: raw['resource'],
      accessToken: raw['access_token'],
      refreshToken: raw['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenType': tokenType,
      'scope': scope,
      'expiresIn': expiresIn,
      'extExpiresIn': extExpiresIn,
      'expiresOn': expiresOn,
      'notBefore': notBefore,
      'resource': resource,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}