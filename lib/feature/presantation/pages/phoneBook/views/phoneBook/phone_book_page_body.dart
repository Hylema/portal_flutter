import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBook/phone_book_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/local/phone_book_local_search.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneBookPageBody extends StatelessWidget {
  final List<PhoneBookModel> listPhoneBook;
  final bool fromCache;
  final PhoneBookBloc bloc;
  PhoneBookPageBody({@required this.listPhoneBook, this.fromCache = false, @required this.bloc});

  @override
  Widget build(BuildContext context) {

//    ScrollController hideButtonController = new ScrollController();
//    bool isVisible = true;
//
//    hideButtonController.addListener(() {
//      if (hideButtonController.position.userScrollDirection ==
//          ScrollDirection.reverse) {
//        if(isVisible) BlocProvider.of<NavigationBarBloc>(context).add(hideNavigationBarEvent());
//        isVisible = false;
//      }
//      if (hideButtonController.position.userScrollDirection ==
//          ScrollDirection.forward) {
//        if(!isVisible) BlocProvider.of<NavigationBarBloc>(context).add(showNavigationBarEvent());
//        isVisible = true;
//      }
//    });

    return CustomScrollView(
//      controller: hideButtonController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            DataFromCacheMessageWidget(fromCache: fromCache),
            PhoneBookLocalSearch(bloc: bloc)
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, index){
            return PhoneBookCreateItem(phoneBookModel: listPhoneBook[index]);
          },
              childCount: listPhoneBook.length
          ),
        ),
      ],
    );
  }
}