//import 'dart:async';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
//import 'package:stacked/stacked.dart';
//
//class BookingRamoteSearchUsersViewModel extends BaseViewModel {
//  final BookingBloc bloc;
//  BookingRamoteSearchUsersViewModel({@required this.bloc}){
//    focusNode.addListener(() {
//      notifyListeners();
//    });
//  }
//
//  TextEditingController textEditingController = new TextEditingController();
//  FocusNode focusNode = new FocusNode();
//  Timer _debounce;
//
//  void onChanged(String value) {
//    notifyListeners();
//
//    if (_debounce?.isActive ?? false) _debounce.cancel();
//    _debounce = Timer(const Duration(milliseconds: 500), () {
//      bloc.add(SearchUsersEvent(value: value));
//    });
//  }
//
//  void clearSearch() {
//    textEditingController.clear();
//    bloc.add(SearchUsersEvent(value: ''));
//  }
//}