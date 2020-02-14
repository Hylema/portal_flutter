import 'dart:convert';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
abstract class IMainParamsJsonDataSource {

  Future<MainParamsModel> getFromJson();
  setToJson(params);
}

class MainParamsJsonDataSource implements IMainParamsJsonDataSource {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final String fileName = 'main_params.json';

    try {
      final path = await _localPath;
      return File('$path/$fileName');
    } catch(e){

      final localPath = await _localPath;
      return File('$localPath/$fileName');
    }
  }

  Future readFile() async {
    try {
      final file = await _localFile;

      return jsonDecode(file.readAsStringSync());
    } catch(e) {
      final String path = 'assets/icons/';
      final data = [
        {
          'name': 'Новости',
          'status': true,
          'icon': '${path}news.png'
        },
        {
          'name': 'Опросы',
          'status': true,
          'icon': '${path}polls.png'
        },
        {
          'name': 'Видеогалерея',
          'status': true,
          'icon': '${path}videoGallery.png'
        },
        {
          'name': 'Дни рождения',
          'status': false,
          'icon': '${path}birthday.png',
        },
        {
          'name': 'Бронирование переговорных',
          'status': false,
          'icon': '${path}negotiationReservation.png'
        },
      ];

      await writeFile(data);

      final file = await _localFile;

      return jsonDecode(file.readAsStringSync());
    }
  }

  Future writeFile(json) async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode({
      'params': json
    }));
  }

  @override
  Future<MainParamsModel> getFromJson() async {
    final file = await readFile();

    if (file != null) {
      return Future.value(MainParamsModel.fromJson(file));
    } else {
      throw JsonException();
    }
  }

  @override
  setToJson(params) async {
    try {
      final file = await writeFile(params);
      return Future.value(MainParamsModel.fromJson(file));
    } catch(e){
      throw JsonException();
    }
  }
}