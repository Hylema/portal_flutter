import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/past/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/widgets/polls_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivePollsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PastPollsBloc, PastPollsState>(
      // ignore: missing_return
      builder: (context, state) {
        if(state is EmptyPastPolls) {}
        if(state is LoadedPastPolls) {
          if(state.listPastPolls.length > 0) {
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
              body: PollsBody(listPolls: state.listPastPolls,),
            );
          } else {
            return Center(child: Text('Нет опросов в архиве'),);
          }
        }
      },
      listener: (context, state) {},
    );
  }
}