import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_params.dart';
import 'package:flutter_architecture_project/feature/data/params/phoneBook/phone_book_user_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/phoneBook/phone_book_repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final PhoneBookRepository repository;

  PhoneBookBloc({@required this.repository});

//  @override
//  Stream<PhoneBookState> transformEvents(
//      Stream<PhoneBookEvent> events,
//      Stream<PhoneBookState> Function(PhoneBookEvent event) next) =>
//      super.transformEvents(
//        events.debounceTime(
//          Duration(milliseconds: 700),
//        ),
//        next,
//      );

  @override
  PhoneBookState get initialState => InitialPhoneBookState();

  @override
  Stream<PhoneBookState> mapEventToState(
    PhoneBookEvent event,
  ) async* {
    if(event is FirstFetchPhoneBookEvent) yield LoadedPhoneBookState(phoneBooks: await repository.firstFetchPhoneBook(params: _phoneBookParams));

    else if(event is LocalPhoneBookSearchEvent) yield* _changePhoneBookList(event);
    else if(event is LocalPhoneBookUserSearchEvent) yield* _changePhoneBookUserList(event);

    else if(event is FetchPhoneBookEvent) yield* _fetchPhoneBook(event);
    else if(event is FetchPhoneBookUserEvent) yield* _fetchPhoneBookUser(event);
    else if(event is UpdatePhoneBookUserEvent) yield* _updatePhoneBookUser(event);

    else if(event is SearchPhoneBookUserEvent) yield* _searchPhoneBookUser(event);
    else if(event is UpdateFoundPhoneBookUserEvent) yield* _updateFoundPhoneUserBook(event);
    else if(event is FetchFoundPhoneBookUserEvent) yield* _fetchFoundPhoneBookUser(event);
    else if(event is ClearPhoneBookUserEvent) {
      if(_phoneBookUserParams.departmentCode != null){
        final String cacheKey = '${_phoneBookUserParams.departmentCode}_$PHONE_BOOK_USER_CACHE_KEY';
        List<PhoneBookUserModel> listPhoneBookUserModel = repository.getPhoneBookUserFromCache(key: cacheKey);
        yield LoadedPhoneBookUserState(phoneBooksUser: listPhoneBookUserModel);
      } else yield LoadedPhoneBookUserState(phoneBooksUser: []);
    }
  }

  PhoneBookParams _phoneBookParams = new PhoneBookParams(parentCode: '');
  PhoneBookUserParams _phoneBookUserParams = new PhoneBookUserParams();

  Stream<PhoneBookState> _changePhoneBookList(LocalPhoneBookSearchEvent event) async* {
    final String cacheKey = '${_phoneBookParams.parentCode}_$PHONE_BOOK_CACHE_KEY';
    List<PhoneBookModel> listPhoneBookModel = repository.getPhoneBookFromCache(key: cacheKey);
    List<PhoneBookModel> newListPhoneBookModel = [];

    listPhoneBookModel.forEach((PhoneBookModel model) {
      String findString = RegExp((event.value).toLowerCase()).firstMatch((model.name).toLowerCase())?.group(0);

      if(findString != null){
        model.searchString = findString;
        newListPhoneBookModel.add(model);
      }
    });

    yield LoadedPhoneBookState(phoneBooks: newListPhoneBookModel);
  }

  Stream<PhoneBookState> _changePhoneBookUserList(LocalPhoneBookUserSearchEvent event) async* {
    final String cacheKey = '${_phoneBookUserParams.departmentCode}_$PHONE_BOOK_USER_CACHE_KEY';
    List<PhoneBookUserModel> listPhoneBookUserModel = repository.getPhoneBookUserFromCache(key: cacheKey);
    List<PhoneBookUserModel> newListPhoneBookModel = [];

    listPhoneBookUserModel.forEach((PhoneBookUserModel model) {
      String searchManageName = RegExp((event.value).toLowerCase()).firstMatch((model.managerFullName).toLowerCase())?.group(0);
      String searchDepartmentName = RegExp((event.value).toLowerCase()).firstMatch((model.departmentName).toLowerCase())?.group(0);

      if(searchManageName != null || searchDepartmentName != null){
        model.searchStringName = searchManageName;
        model.searchStringDepartment = searchDepartmentName;
        newListPhoneBookModel.add(model);
      }
    });

    yield LoadedPhoneBookUserState(phoneBooksUser: newListPhoneBookModel);
  }

  Stream<PhoneBookState> _fetchPhoneBook(FetchPhoneBookEvent event) async* {
    _phoneBookParams.parentCode = event.parentCode;

    List<PhoneBookModel> models =
    await repository.fetchPhoneBook(params: _phoneBookParams, update: event.update);

    yield LoadedPhoneBookState(phoneBooks: models);
  }

  Stream<PhoneBookState> _fetchPhoneBookUser(FetchPhoneBookUserEvent event) async* {
    final currentState = state;

    if(currentState is LoadedPhoneBookUserState){
      _phoneBookUserParams.pageIndex += 1;
      List<PhoneBookUserModel> models =
      await repository.fetchPhoneBookUsers(params: _phoneBookUserParams);

      yield models.isEmpty
          ? currentState.copyWith(hasReachedMax: true)
          : LoadedPhoneBookUserState(
        phoneBooksUser: currentState.phoneBooksUser + models,
        hasReachedMax: false,
      );
    } else {
      yield LoadingPhoneBookState();
      _phoneBookUserParams.departmentCode = event.parentCode;

      List<PhoneBookUserModel> models =
      await repository.fetchPhoneBookUsers(params: _phoneBookUserParams);

      yield LoadedPhoneBookUserState(phoneBooksUser: models, hasReachedMax: false);
    }
  }

  Stream<PhoneBookState> _updatePhoneBookUser(UpdatePhoneBookUserEvent event) async* {
    _phoneBookUserParams.pageIndex = 1;

    List<PhoneBookUserModel> models =
    await repository.fetchPhoneBookUsers(params: _phoneBookUserParams);

    yield LoadedPhoneBookUserState(phoneBooksUser: models);
  }

  Stream<PhoneBookState> _searchPhoneBookUser(SearchPhoneBookUserEvent event) async* {
    yield LoadingPhoneBookState();

    _phoneBookUserParams.searchString = event.searchString;
    _phoneBookUserParams.departmentCode = event.parentCode;

    List<PhoneBookUserModel> models =
    await repository.searchPhoneBookUser(params: _phoneBookUserParams);

    yield LoadedPhoneBookUserState(phoneBooksUser: models);
  }

  Stream<PhoneBookState> _fetchFoundPhoneBookUser(FetchFoundPhoneBookUserEvent event) async* {
    final currentState = state;

    if(currentState is LoadedPhoneBookUserState){
      _phoneBookUserParams.pageIndex += 1;
      List<PhoneBookUserModel> models =
      await repository.searchPhoneBookUser(params: _phoneBookUserParams);

      yield models.isEmpty
          ? currentState.copyWith(hasReachedMax: true)
          : LoadedPhoneBookUserState(
        phoneBooksUser: currentState.phoneBooksUser + models,
        hasReachedMax: false,
      );
    }
  }

  Stream<PhoneBookState> _updateFoundPhoneUserBook(UpdateFoundPhoneBookUserEvent event) async* {
    _phoneBookUserParams.pageIndex = 1;

    List<PhoneBookUserModel> models =
    await repository.searchPhoneBookUser(params: _phoneBookUserParams);

    yield LoadedPhoneBookUserState(phoneBooksUser: models);
  }
}
