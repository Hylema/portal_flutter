import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/archive_polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/widgets/polls_item.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';

class PollsBody extends StatelessWidget {
  final List<PollsModel> listPolls;
  PollsBody({@required this.listPolls});

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
      enableControlLoad: false,
      enableControlRefresh: false,
      hasReachedMax: false,
      child: CustomScrollView(
        controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Text(
                    '2019',
                    style: TextStyle(
                        color: Color.fromRGBO(119, 134, 147, 1)
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              return PollsItem(currentPoll: listPolls[index]);
            },
                childCount: listPolls.length
            ),
          ),
        ],
      ),
    );
  }
}
