import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:stacked/stacked.dart';

class PhoneBookRemoteSearchViewModel extends BaseViewModel {
  final PhoneBookBloc bloc;
  final FocusScopeNode focusScope;
  final String departmentCode;
  PhoneBookRemoteSearchViewModel({
    @required this.bloc,
    @required this.focusScope,
    @required this.departmentCode,
  });

  Timer _debounce;
  bool closeButton = false;
  TextEditingController searchController = TextEditingController();

  void onChanged(String value) {
    notifyListeners();

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      if(value == '') bloc.add(ClearPhoneBookUserEvent());
      else bloc.add(SearchPhoneBookUserEvent(searchString: value, parentCode: departmentCode));
    });
  }

  void onTap() {
    openKeyBoardPanel();
  }

  void onSubmit() {
    closeKeyBoardPanel();
  }

  void openKeyBoardPanel(){
    closeButton = true;
    notifyListeners();
  }

  void closeKeyBoardPanel(){
    focusScope.unfocus();
    closeButton = false;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    bloc.add(ClearPhoneBookUserEvent());
    notifyListeners();
  }
}