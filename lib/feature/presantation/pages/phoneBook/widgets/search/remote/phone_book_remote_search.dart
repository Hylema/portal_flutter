import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/phoneBookUsers/phone_book_users_page_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/views/shimmers/phone_book_users_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/search/remote/phone_book_remote_search_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
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
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.grey[200],
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  child: Icon(Icons.search, color: Colors.grey,),
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: model.searchController,
                                    onTap: () => model.onTap(),
                                    onSubmitted: (value) => model.onSubmit(),
                                    onChanged: (value) => model.onChanged(value),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                      hintText: 'Поиск',
                                      suffixIcon: model.searchController.text.length > 0
                                          ? IconButton(
                                        onPressed: () => model.clearSearch(),
                                        icon: Icon(
                                          Icons.cancel,
                                          size: 14,
                                          color: Colors.grey[400],
                                        ),
                                      ) : null,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      )

                  )
              ),
              AnimatedCrossFade(
                crossFadeState: model.closeButton ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                //alwaysIncludeSemantics: true,
                duration: Duration(milliseconds: 200),
                firstChild: GestureDetector(
                  onTap: () => model.closeKeyBoardPanel(),
                  child: Padding(
                      child: Text(
                        'Отменить',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 16
                        ),
                      ),
                      padding: EdgeInsets.only(right: 15)),
                ),
                secondChild: SizedBox(height: 0, width: 0,),
              ), Container(),
            ],
          ),
      viewModelBuilder: () => PhoneBookRemoteSearchViewModel(
          bloc: bloc,
          focusScope: FocusScope.of(context),
          departmentCode: departmentCode
      ),
    );
  }
}