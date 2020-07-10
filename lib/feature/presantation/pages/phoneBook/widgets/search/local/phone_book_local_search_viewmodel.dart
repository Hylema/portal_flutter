import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:stacked/stacked.dart';

class PhoneBookLocalSearchViewModel extends BaseViewModel {
  final PhoneBookBloc bloc;
  final bool userPage;
  final NavigationBarBloc navigationBarBloc;

  PhoneBookLocalSearchViewModel({
    @required this.bloc,
    @required this.navigationBarBloc,
    this.userPage = false
  }){
    focusNode.addListener(() {
      notifyListeners();
    });
  }

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = new FocusNode();

  void onChanged(String value) {
    if(userPage) bloc.add(LocalPhoneBookUserSearchEvent(value: value));
    else bloc.add(LocalPhoneBookSearchEvent(value: value));
  }

  void onTap() {}

  void onSubmit(String value) {}

  void clearSearch() {
    searchController.clear();
    if(userPage) bloc.add(LocalPhoneBookUserSearchEvent(value: ''));
    else bloc.add(LocalPhoneBookSearchEvent(value: ''));
  }
}