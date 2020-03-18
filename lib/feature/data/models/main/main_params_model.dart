import 'package:meta/meta.dart';

class MainParamsModel {
  final params;

  MainParamsModel({
    @required this.params,
  });

  factory MainParamsModel.fromJson(json) {
    return MainParamsModel(
      params: json['params'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'params': params,
    };
  }
}