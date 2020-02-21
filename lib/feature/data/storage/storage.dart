import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Storage {

  Storage(){
    getData();
  }

  String token;
  Map<String, dynamic> tokenDecode;

  getData() async {
    FlutterSecureStorage secureStorage = new FlutterSecureStorage();
    token = await secureStorage.read(key: JWT_TOKEN);

    tokenDecode = Jwt.parseJwt(token);
  }
}