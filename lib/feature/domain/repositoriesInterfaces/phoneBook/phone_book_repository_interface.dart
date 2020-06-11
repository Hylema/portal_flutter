import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params_response.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_user_params.dart';

abstract class IPhoneBookRepository {
  Future<List<PhoneBookModel>> fetchPhoneBook({
    @required PhoneBookParams params,
    bool update = false
  });

  Future<List<PhoneBookUserModel>> fetchPhoneBookUsers({
    @required PhoneBookUserParams params,
  });

  Future<List<PhoneBookModel>> firstFetchPhoneBook({
    @required PhoneBookParams params,
  });

  Future<List<PhoneBookUserModel>> searchPhoneBookUser({
    @required PhoneBookUserParams params,
  });
}