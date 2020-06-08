import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/phone_book_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_users_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_users_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneBookPage extends StatelessWidget {
  final PhoneBookBloc bloc;
  final bool automaticallyImplyLeading;
  final bool childrenExists;
  final String title;
  PhoneBookPage({@required this.bloc, this.title, this.automaticallyImplyLeading, this.childrenExists = false});

  Widget build(BuildContext context) {
    return BlocConsumer<PhoneBookBloc, PhoneBookState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = Container();

        if(!childrenExists) currentViewOnPage = Container(color: Colors.white, child: PhoneBookUsersPageShimmer());
        else currentViewOnPage = Container(color: Colors.white, child: PhoneBookPageShimmer());

        if(state is LoadedPhoneBookState){
          currentViewOnPage = PhoneBookPageBody(listPhoneBook: state.phoneBooks, that: title == null ? AppPage() : this);
        }

        if(state is LoadedPhoneBookUserState){
          if(state.phoneBooksUser.length == 0) currentViewOnPage = Center(child: Text('Нет данных'));
          else currentViewOnPage = PhoneBookUsersPageBody(listPhoneUsersBook: state.phoneBooksUser);
        }

        return Scaffold(
          appBar: HeaderAppBar(
            title: title ?? 'Телефонный справочник',
            automaticallyImplyLeading: automaticallyImplyLeading ?? false,
            backButtonColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: currentViewOnPage,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
