import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday_params.dart';

abstract class IBirthdayRepository {
  Future<List<BirthdayModel>> getBirthdayWithConcreteDay({
    @required BirthdayParams params,
  });

  Future<List<BirthdayModel>> getBirthdayWithFilter({
    @required BirthdayParams params,
  });

  BirthdayModel getBirthdayFromCache();

  Future<void> setBirthdayToCache();
}