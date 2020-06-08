import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/archive_polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/widgets/polls_body.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollsPage extends StatelessWidget {
  final PollsBloc bloc;
  PollsPage({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PollsBloc, PollsState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = Center(child: Text('Нет текущих опросов'),);

        if(state is InitialPollsState) {}
        if(state is LoadedPollsState) {
          if(state.listPolls.length > 0) {
            currentViewOnPage = PollsBody(listPolls: state.listPolls);
          } else {
            currentViewOnPage = Center(child: Text('Нет текущих опросов'),);
          }
        }

        return Scaffold(
            appBar: HeaderAppBar(
              title: 'Опросы',
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 7,
                      bottom: 7
                  ),
                  child: IconButton(
                      onPressed: (){
                        Navigator.push(context, EnterExitRoute(exitPage: AppPage(), enterPage: ArchivePollsPage()));
                      },
                      icon: Image.asset(
                        'assets/icons/archivePolls.png',
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 15.0,
                      top: 7,
                      bottom: 7
                  ),
//            child: IconButton(
////                onPressed: (){
////                  Navigator.push(context, ScaleRoute(page: BirthdayPageParameters()));
////                },
//                icon: Image.asset(
//                  'assets/icons/change.png',
//                )
//            ),
                ),
              ],
            ),
            body: Scrollbar(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: currentViewOnPage,
              ),
            )
        );
      },
      listener: (context, state) {},
    );
  }
}
