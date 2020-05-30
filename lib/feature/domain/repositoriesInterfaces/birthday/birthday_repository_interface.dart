import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params_response.dart';

abstract class IBirthdayRepository {
  Future<BirthdayResponse> fetchBirthday({
    @required BirthdayParams params,
    bool update = false
  });

  BirthdayResponse getBirthdayFromCache();

  Future<void> saveBirthdayToCache();
  Future<void> updateBirthdayCache();
}