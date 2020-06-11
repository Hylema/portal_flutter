import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookUsers/phone_book_user_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';

class PhoneBookRemoteSearchBody extends StatelessWidget {
  final List<PhoneBookUserModel> listPhoneUsersBook;
  final bool fromCache;
  final bool hasReachedMax;
  final PhoneBookBloc bloc;
  PhoneBookRemoteSearchBody({@required this.listPhoneUsersBook, this.fromCache = false, @required this.bloc, this.hasReachedMax = false});
  @override
  Widget build(BuildContext context) {

    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      hasReachedMax: hasReachedMax,
      onRefresh: () => bloc.add(UpdateFoundPhoneBookUserEvent()),
      onLoading: () => bloc.add(FetchFoundPhoneBookUserEvent()),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index){
              return PhoneBookUserCreateItem(phoneBookUserModel: listPhoneUsersBook[index]);
            },
                childCount: listPhoneUsersBook.length
            ),
          ),
        ],
      ),
    );
  }
}
