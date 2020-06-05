import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params_response.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';

abstract class IPhoneBookRepository {
  Future<List<PhoneBookModel>> fetchPhoneBook({
    @required PhoneBookParams params,
    bool update = false
  });
}