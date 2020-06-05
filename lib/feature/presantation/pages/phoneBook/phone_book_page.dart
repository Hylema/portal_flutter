import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/phone_book_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_create_item.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneBookPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneBookBloc, PhoneBookState>(
      builder: (context, state) {
        Widget currentViewOnPage = Container();

        if(state is LoadedPhoneBookState){
          currentViewOnPage = PhoneBookPageBody(listPhoneBook: state.phoneBooks);
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: currentViewOnPage,
        );
      },
      listener: (context, state) {},
    );
  }
}
