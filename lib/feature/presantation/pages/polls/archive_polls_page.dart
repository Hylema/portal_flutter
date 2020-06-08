import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/widgets/polls_body.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/widgets/polls_page_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ArchivePollsPage extends StatelessWidget {
  final getIt = GetIt.instance;
  PollsBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = getIt<PollsBloc>();
    bloc.add(FetchPastPollsEvent());

    return BlocConsumer<PollsBloc, PollsState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = PollsPageShimmer();

        if(state is InitialPollsState) {}
        if(state is LoadedPollsState) {
          if(state.listPolls.length > 0) {
            currentViewOnPage = PollsBody(listPolls: state.listPolls);
          } else {
            currentViewOnPage = Center(child: Text('Нет опросов в архиве'),);
          }
        }

        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: Text('Архив опросов', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: 15.0,
                    top: 7,
                    bottom: 7
                ),
                child: IconButton(
//                        onPressed: (){
//                          Navigator.push(context, ScaleRoute(page: BirthdayPageParameters()));
//                        },
                    icon: Image.asset(
                      'assets/icons/change.png',
                    )
                ),
              ),
            ],
          ),
          body: currentViewOnPage
        );
      },
      listener: (context, state) {},
    );
  }
}