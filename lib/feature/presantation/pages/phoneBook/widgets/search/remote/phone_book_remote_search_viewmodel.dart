import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:stacked/stacked.dart';

class PhoneBookRemoteSearchViewModel extends BaseViewModel {
  final PhoneBookBloc bloc;
  final String departmentCode;
  PhoneBookRemoteSearchViewModel({
    @required this.bloc,
    @required this.departmentCode,
  }){
    focusNode.addListener(() {
      notifyListeners();
    });
  }

  Timer _debounce;
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = new FocusNode();

  void onChanged(String value) {
    notifyListeners();

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      if(value == '') bloc.add(ClearPhoneBookUserEvent());
      else bloc.add(SearchPhoneBookUserEvent(searchString: value, parentCode: departmentCode));
    });
  }

  void onTap() {}

  void onSubmit(String value) {}

  void clearSearch() {
    searchController.clear();
    bloc.add(ClearPhoneBookUserEvent());
    notifyListeners();
  }
}