import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_user_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/phoneBook/phone_book_repository.dart';
import './bloc.dart';

class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final PhoneBookRepository repository;

  PhoneBookBloc({@required this.repository});

  @override
  PhoneBookState get initialState => InitialPhoneBookState();

  @override
  Stream<PhoneBookState> mapEventToState(
    PhoneBookEvent event,
  ) async* {
    if(event is FirstFetchPhoneBookEvent) yield LoadedPhoneBookState(phoneBooks: await repository.firstFetchPhoneBook(params: _phoneBookParams));
    else if(event is FetchPhoneBookEvent) yield* _fetchPhoneBook(event);
    else if(event is FetchPhoneBookUserEvent) yield* _fetchPhoneUserBook(event);
  }

  PhoneBookParams _phoneBookParams = new PhoneBookParams(parentCode: null);
  PhoneBookUserParams _phoneBookUserParams = new PhoneBookUserParams(
    pageSize: 100,
    pageIndex: 1,
    departmentCode: null,
  );

  Stream<PhoneBookState> _fetchPhoneBook(FetchPhoneBookEvent event) async* {
    _phoneBookParams.parentCode = event.parentCode;

    List<PhoneBookModel> listPhoneBookModel =
    await repository.fetchPhoneBook(params: _phoneBookParams, update: event.update);

    yield LoadedPhoneBookState(phoneBooks: listPhoneBookModel);
  }

  Stream<PhoneBookState> _fetchPhoneUserBook(FetchPhoneBookUserEvent event) async* {
    _phoneBookUserParams.departmentCode = event.parentCode;

    List<PhoneBookUserModel> listPhoneBookUserModel =
    await repository.fetchPhoneBookUsers(params: _phoneBookUserParams);

    yield LoadedPhoneBookUserState(phoneBooksUser: listPhoneBookUserModel);
  }
}
