import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PollsMainPageCustomSwipeWidget extends StatelessWidget {
  final PollsBloc bloc;
  PollsMainPageCustomSwipeWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PollsBloc, PollsState>(
      bloc: bloc,
      builder: (context, state) {
        if(state is InitialPollsState) {
          return Container();
        }
        if(state is LoadedPollsState) {
          if(state.listPolls.length > 0) {
            return PollsMainPageCustomSwipeBodyWidget(listPolls: state.listPolls);
          } else {
            return Center(child: Text('Нет текущих опросов'),);
          }
        }
      },
      listener: (context, state) {},
    );
  }
}

class PollsMainPageCustomSwipeBodyWidget extends StatelessWidget {
  final List<PollsModel> listPolls;
  PollsMainPageCustomSwipeBodyWidget({@required this.listPolls});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return PollsMainPageItemWidget(poll: listPolls[index],);

          }, itemCount: listPolls.length,)
//      child: ListView(
//        scrollDirection: Axis.horizontal,
//        children: <Widget>[
//          Container(
//            height: 100,
//            width: MediaQuery.of(context).size.width / 1.3,
//            padding: EdgeInsets.only(left: 20),
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(10),
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.black12.withOpacity(0.005),
//                  blurRadius: 15.0,
//                  spreadRadius: 0.2,
//                  offset: Offset(
//                    10, // horizontal, move right 10
//                    10, // vertical, move down 10
//                  ),
//                ),
//              ],
//            ),
//            child: Card(
//              child: Wrap(
//                children: <Widget>[
//                  ListTile(
//                    title: Text(
//                      'Опрос о качестве нового портала',
//                      style: TextStyle(fontWeight: FontWeight.bold),
//                    ),
//                    subtitle: Text(
//                      'Удобство использования',
//                      style: TextStyle(fontSize: 12),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
    );
  }
}

class PollsMainPageItemWidget extends StatelessWidget {
  final PollsModel poll;
  PollsMainPageItemWidget({@required this.poll});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 1.3,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.005),
            blurRadius: 15.0,
            spreadRadius: 0.2,
            offset: Offset(
              10, // horizontal, move right 10
              10, // vertical, move down 10
            ),
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          dense: true,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebviewScaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: true,
                        backgroundColor: Colors.red[800],
                      ),
                      url: poll.link
                  ),
                )
            ),
            title: Text(
              '${poll.title}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                Text(
                  '${poll.type} ',
                  style: TextStyle(fontSize: 12),
                ),
                DateTimeWidget(
                  dataTime: poll.created,
                  color: Colors.grey[600],
                ),
              ],
            )
        )
      ),
    );
  }
}

