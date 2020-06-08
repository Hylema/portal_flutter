import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_users_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_users_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PhoneBookCreateItem extends StatelessWidget {
  final PhoneBookModel phoneBookModel;
  final that;
  final getIt = GetIt.instance;
  PhoneBookCreateItem({@required this.phoneBookModel, @required this.that});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(phoneBookModel.name),
            trailing: phoneBookModel.childrenCount != 0 ? Icon(Icons.chevron_right) : null,
            dense: true,
            onTap: () => Navigator.push(context,
                EnterExitRoute(
                    exitPage: that,
                    enterPage: BlocProvider<PhoneBookBloc>(
                      create: (BuildContext context) => PhoneBookBloc(repository: getIt()),
                      child: NextPage(phoneBookModel: phoneBookModel,),
                    )
                )
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: 1,
          )
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final PhoneBookModel phoneBookModel;
  final getIt = GetIt.instance;

  NextPage({@required this.phoneBookModel});

  @override
  Widget build(BuildContext context) {
    if(phoneBookModel.childrenCount == 0)  context.bloc<PhoneBookBloc>().add(FetchPhoneBookUserEvent(parentCode: phoneBookModel.code));
    else context.bloc<PhoneBookBloc>().add(FetchPhoneBookEvent(parentCode: phoneBookModel.code));

    return BlocBuilder<PhoneBookBloc, PhoneBookState>(
      builder: (context, state) {
        Widget currentViewOnPage;
        if(phoneBookModel.childrenCount == 0) currentViewOnPage = Container(color: Colors.white, child: PhoneBookUsersPageShimmer(),);
        else currentViewOnPage = Container(color: Colors.white, child: PhoneBookPageShimmer(),);

        print('state is ${state.runtimeType}');

        if(state is LoadedPhoneBookState){
          currentViewOnPage = PhoneBookPageBody(listPhoneBook: state.phoneBooks, that: this,);
        }

        if(state is LoadedPhoneBookUserState){
          if(state.phoneBooksUser.length == 0) currentViewOnPage = Center(child: Text('Нет данных'));
          else currentViewOnPage = PhoneBookUsersPageBody(listPhoneUsersBook: state.phoneBooksUser);
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Scaffold(
            appBar: HeaderAppBar(
              title: phoneBookModel.name,
              automaticallyImplyLeading: true,
            ),
            body: currentViewOnPage
          ),
        );
      },
    );
  }
}