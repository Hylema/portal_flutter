import 'package:flutter_architecture_project/feature/domain/entities/main/main_params.dart';
import 'package:meta/meta.dart';

class MainParamsModel extends MainParams {
  MainParamsModel({
    @required params,
  }) : super(
    params: params,
  );

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