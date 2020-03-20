import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Storage {

  Storage(){
    updateData();
  }

  String token;
  String secondToken;
  Map<String, dynamic> tokenDecode;

  updateData() async {
    FlutterSecureStorage secureStorage = new FlutterSecureStorage();
    token = await secureStorage.read(key: JWT_TOKEN);
    secondToken = await secureStorage.read(key: JWT_TOKEN_SECOND);
  }
}