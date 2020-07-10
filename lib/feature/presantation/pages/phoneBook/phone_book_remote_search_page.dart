import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookRemoteSearch/phone_book_remote_search_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookUsers/phone_book_users_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_remote_search_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_users_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/remote/phone_book_remote_search.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/remote/phone_book_remote_search_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class PhoneBookRemoteSearchPage extends StatelessWidget {
  final PhoneBookBloc bloc;

  PhoneBookRemoteSearchPage({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneBookBloc, PhoneBookState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = Container();

        if(state is LoadedPhoneBookUserState){
          currentViewOnPage = PhoneBookRemoteSearchBody(listPhoneUsersBook: state.phoneBooksUser, bloc: bloc, hasReachedMax: state.hasReachedMax,);
        }

        if(state is LoadingPhoneBookState) {
          currentViewOnPage = PhoneBookRemoteSearchPageShimmer();
        }

        return Scaffold(
            appBar: HeaderAppBar(
              automaticallyImplyLeading: true,
              backButtonColor: Colors.black,
              actions: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 10,
                  child: PhoneBookRemoteSearch(bloc: bloc,),
                ),
              ],
            ),
            body: Scrollbar(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: currentViewOnPage,
              ),
            )
        );

        return Scrollbar(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: currentViewOnPage,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}