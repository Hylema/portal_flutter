import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';

class PhoneBookPageBody extends StatelessWidget {
  final List<PhoneBookModel> listPhoneBook;
  final bool fromCache;
  PhoneBookPageBody({@required this.listPhoneBook, this.fromCache = false});

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
            return PhoneBookCreateItem(phoneBookModel: listPhoneBook[index]);
          },
              childCount: listPhoneBook.length
          ),
        ),
      ],
    );
  }
}