import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IAuthLocalDataSource {
  saveTokens();
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  final FlutterSecureStorage flutterSecureStorage;
  final Storage storage;

  AuthLocalDataSource({
    @required this.flutterSecureStorage,
    @required this.storage,
  });

  @override
  saveTokens({@required String firstToken, @required String secondToken}) async {
    await flutterSecureStorage.write(key: JWT_TOKEN, value: firstToken);
    ///Декодирование jwt token, может понадобится в будущем
    //await flutterSecureStorage.write(key: JWT_DECODE, value: jsonEncode(Jwt.parseJwt(token)));
    await flutterSecureStorage.write(key: JWT_TOKEN_SECOND, value: secondToken);
    storage.updateData();
  }
}