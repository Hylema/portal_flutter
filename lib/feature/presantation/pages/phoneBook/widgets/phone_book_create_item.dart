import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/phone_book_page.dart';
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
            title: Text('${phoneBookModel.name}'),
            trailing: phoneBookModel.childrenExists ? Icon(Icons.chevron_right) : null,
            dense: true,
            onTap: () => Navigator.push(context,
                EnterExitRoute(
                    exitPage: that,
                    enterPage: NextPage(phoneBookModel: phoneBookModel, bloc: getIt<PhoneBookBloc>())
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
  final PhoneBookBloc bloc;

  NextPage({@required this.phoneBookModel, @required this.bloc});

  @override
  Widget build(BuildContext context) {
    if(!phoneBookModel.childrenExists) bloc.add(FetchPhoneBookUserEvent(parentCode: phoneBookModel.code));
    else bloc.add(FetchPhoneBookEvent(parentCode: phoneBookModel.code));

    return PhoneBookPage(bloc: bloc, automaticallyImplyLeading: true, title: phoneBookModel.name, childrenExists: phoneBookModel.childrenExists);
  }
}