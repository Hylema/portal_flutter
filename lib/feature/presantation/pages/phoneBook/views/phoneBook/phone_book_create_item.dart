import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/phone_book_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/phone_book_show_list_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_search_bold_text.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PhoneBookCreateItem extends StatelessWidget {
  final PhoneBookModel phoneBookModel;
  final getIt = GetIt.instance;
  PhoneBookCreateItem({@required this.phoneBookModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: PhoneBookSearchBoldText(searchString: phoneBookModel.searchString, text: phoneBookModel.name),
            trailing: phoneBookModel.childrenExists ? Icon(Icons.chevron_right) : null,
            dense: true,
            onTap: () {
              final PhoneBookBloc phoneBookPageBloc = getIt<PhoneBookBloc>();

              if(!phoneBookModel.childrenExists) phoneBookPageBloc.add(FetchPhoneBookUserEvent(parentCode: phoneBookModel.code));
              else phoneBookPageBloc.add(FetchPhoneBookEvent(parentCode: phoneBookModel.code));

              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => PhoneBookPage(bloc: phoneBookPageBloc, automaticallyImplyLeading: true, title: phoneBookModel.name, childrenExists: phoneBookModel.childrenExists)
                  )
              );
            },
            onLongPress: phoneBookModel.childrenExists ? () {
              final PhoneBookBloc phoneBookShowListPageBloc = getIt<PhoneBookBloc>();

              phoneBookShowListPageBloc.add(FetchPhoneBookUserEvent(parentCode: phoneBookModel.code));

              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => PhoneBookShowListPage(departmentCode: phoneBookModel.code, bloc: phoneBookShowListPageBloc, title: phoneBookModel.name)
                  )
              );
            } : null
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  width: 0.8,
                  color: Colors.grey[400],
                ))
            ),
          ),
        ],
      ),
    );
  }
}
