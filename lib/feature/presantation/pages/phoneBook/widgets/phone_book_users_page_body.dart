import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneBookUsersPageBody extends StatelessWidget {
  final List<PhoneBookUserModel> listPhoneUsersBook;
  final bool fromCache;
  PhoneBookUsersPageBody({@required this.listPhoneUsersBook, this.fromCache = false});

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      controller: GlobalState.hideAppNavigationBarController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            DataFromCacheMessageWidget(fromCache: fromCache),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, index){
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(listPhoneUsersBook[index].managerFullName),
                  subtitle: Text(listPhoneUsersBook[index].departmentName),
                  leading: CircleAvatar(
                      foregroundColor: Colors.red,
                      //radius: 60.0,
                      backgroundColor: Colors.white,
                      //backgroundImage: NetworkImage('https://dollarquiltingclub.com/wp-content/uploads/2018/09/noPhoto.png'),
                      child: Image.asset('assets/images/noPhoto.png')
                  ),
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
            );
          },
              childCount: listPhoneUsersBook.length
          ),
        ),
      ],
    );
  }
}
