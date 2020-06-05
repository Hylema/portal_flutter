import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/phoneBook/phone_book_repository.dart';
import './bloc.dart';

class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final PhoneBookRepository repository;
  final NetworkInfo networkInfo;

  PhoneBookBloc({@required this.repository, @required this.networkInfo});

  @override
  PhoneBookState get initialState => InitialPhoneBookState();

  @override
  Stream<PhoneBookState> mapEventToState(
    PhoneBookEvent event,
  ) async* {
    if(event is FetchPhoneBookEvent) yield* _fetchPhoneBook(event);
  }

  PhoneBookParams _phoneBookParams = new PhoneBookParams(parentCode: '');

  Stream<PhoneBookState> _fetchPhoneBook(FetchPhoneBookEvent event) async* {
    _phoneBookParams.parentCode = event.parentCode;

    List<PhoneBookModel> listPhoneBookModel =
    await repository.fetchPhoneBook(params: _phoneBookParams);

    yield LoadedPhoneBookState(phoneBooks: listPhoneBookModel);
  }
}
