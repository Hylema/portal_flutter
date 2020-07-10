import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookUsers/phone_book_user_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/local/phone_book_local_search.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/remote/phone_book_remote_search.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneBookUsersPageBody extends StatelessWidget {
  final List<PhoneBookUserModel> listPhoneUsersBook;
  final bool fromCache;
  final PhoneBookBloc bloc;
  final bool localSearch;
  final bool hasReachedMax;

  PhoneBookUsersPageBody({
    @required this.listPhoneUsersBook,
    this.fromCache = false,
    @required this.bloc,
    this.localSearch = true,
    this.hasReachedMax
  });
  @override
  Widget build(BuildContext context) {

    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      hasReachedMax: hasReachedMax,
      onRefresh: () => bloc.add(UpdatePhoneBookUserEvent()),
      onLoading: () => bloc.add(FetchPhoneBookUserEvent()),
      child: CustomScrollView(
//      controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              DataFromCacheMessageWidget(fromCache: fromCache),
              localSearch ? PhoneBookLocalSearch(bloc: bloc, userPage: true)
                  : Container()
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index){
              return PhoneBookUserCreateItem(
                  phoneBookUserModel: listPhoneUsersBook[index],
                  last: listPhoneUsersBook.length == index + 1
              );
            },
                childCount: listPhoneUsersBook.length
            ),
          ),
        ],
      )
    );
  }
}
