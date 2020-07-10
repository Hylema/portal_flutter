import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/local/phone_book_local_search_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/search_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class PhoneBookLocalSearch extends StatelessWidget {

  final PhoneBookBloc bloc;
  final bool userPage;
  PhoneBookLocalSearch({
    @required this.bloc,
    this.userPage = false
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneBookLocalSearchViewModel>.reactive(
      builder: (context, model, child) =>
      SearchWidget(
        textEditingController: model.searchController,
        onTap: model.onTap,
        onSubmitted: model.onSubmit,
        onChanged: model.onChanged,
        clearSearch: model.clearSearch,
        focusNode: model.focusNode,
      ),
      viewModelBuilder: () => PhoneBookLocalSearchViewModel(
          bloc: bloc,
          userPage: userPage,
          navigationBarBloc: BlocProvider.of<NavigationBarBloc>(context),
      ),
    );
  }
}

