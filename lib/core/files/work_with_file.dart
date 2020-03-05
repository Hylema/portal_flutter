import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WorkWithFile {

  final String key;
  final String filename;

  WorkWithFile({this.filename, this.key}){
    assert(filename != null);
    assert(filename != key);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future readFile() async {
    final file = await _localFile;

    try{
      final json = jsonDecode(file.readAsStringSync());
      return json[key];
    } catch(e){
      await writeFile('1');

      final json = jsonDecode(file.readAsStringSync());
      return json[key];
    }
  }

  Future writeFile(popularity) async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode({
      key: popularity
    }));
  }
}