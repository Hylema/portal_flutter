import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:stacked/stacked.dart';

class PhoneBookLocalSearchViewModel extends BaseViewModel {
  final PhoneBookBloc bloc;
  final bool userPage;
  final NavigationBarBloc navigationBarBloc;
  final FocusScopeNode focusScope;

  PhoneBookLocalSearchViewModel({
    @required this.bloc,
    @required this.navigationBarBloc,
    @required this.focusScope,
    this.userPage = false
  });

  bool closeButton = false;
  TextEditingController searchController = TextEditingController();

  void onChanged(String value) {
    if(userPage) bloc.add(LocalPhoneBookUserSearchEvent(value: value));
    else bloc.add(LocalPhoneBookSearchEvent(value: value));
  }

  void onTap() {
    navigationBarBloc.add(HideNavigationBarEvent());
    openKeyBoardPanel();
  }

  void onSubmit() {
    Future.delayed(Duration(milliseconds: 200)).then((value) => navigationBarBloc.add(ShowNavigationBarEvent()));
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
    if(userPage) bloc.add(LocalPhoneBookUserSearchEvent(value: ''));
    else bloc.add(LocalPhoneBookSearchEvent(value: ''));
  }
}