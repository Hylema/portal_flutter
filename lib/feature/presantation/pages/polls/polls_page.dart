import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/current/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/widgets/polls_body.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentPollsBloc, CurrentPollsState>(
      builder: (context, state) {
        if(state is EmptyCurrentPolls) {}
        if(state is LoadedCurrentPolls) {
          if(state.listCurrentPolls.length > 0) {
            return PollsBody(listPolls: state.listCurrentPolls);
          } else {
            return Center(child: Text('Нет текущих опросов'),);
          }
        }
      },
      listener: (context, state) {},
    );
  }
}
