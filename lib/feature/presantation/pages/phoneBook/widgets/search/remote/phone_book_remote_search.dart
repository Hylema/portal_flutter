import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookUsers/phone_book_users_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_users_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/remote/phone_book_remote_search_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/search_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class PhoneBookRemoteSearch extends StatelessWidget {
  final PhoneBookBloc bloc;
  final String departmentCode;

  PhoneBookRemoteSearch({@required this.bloc, this.departmentCode});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneBookRemoteSearchViewModel>.reactive(
      builder: (context, model, child) =>
          SearchWidget(
            textEditingController: model.searchController,
            onTap: model.onTap,
            onSubmitted: model.onSubmit,
            onChanged: model.onChanged,
            clearSearch: model.clearSearch,
            focusNode: model.focusNode,
          ),
      viewModelBuilder: () => PhoneBookRemoteSearchViewModel(
          bloc: bloc,
          departmentCode: departmentCode
      ),
    );
  }
}