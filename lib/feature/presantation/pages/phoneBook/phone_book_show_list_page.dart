import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/phone_book_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/phone_book_remote_search_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBook/phone_book_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookUsers/phone_book_users_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_remote_search_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_users_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/remote/phone_book_remote_search.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animations/animations.dart';
import 'package:get_it/get_it.dart';
class PhoneBookShowListPage extends StatelessWidget {
  final PhoneBookBloc bloc;
  final String title;
  final String departmentCode;
  final getIt = GetIt.instance;
  PhoneBookShowListPage({@required this.bloc, this.title, @required this.departmentCode});

  Widget build(BuildContext context) {
    return BlocConsumer<PhoneBookBloc, PhoneBookState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = PhoneBookRemoteSearchPageShimmer();

        if(state is LoadedPhoneBookUserState){
          currentViewOnPage = PhoneBookUsersPageBody(listPhoneUsersBook: state.phoneBooksUser, bloc: bloc, localSearch: false, hasReachedMax: state.hasReachedMax);
        }

        return Scaffold(
          appBar: HeaderAppBar(
            title: title ?? 'Телефонный справочник',
            automaticallyImplyLeading: true,
            backButtonColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => PhoneBookRemoteSearchPage(bloc: getIt<PhoneBookBloc>(),),
                      )
                  );
                },
              ),
            ],
          ),
          body: Scrollbar(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Column(
                children: <Widget>[
                  PhoneBookRemoteSearch(bloc: bloc, departmentCode: departmentCode),
                  Expanded(
                    child: currentViewOnPage,
                  )
                ],
              ),
            ),
          )
        );
      },
      listener: (context, state) {},
    );
  }
}
