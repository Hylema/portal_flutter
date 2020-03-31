import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdayPage extends StatefulWidget {

  @override
  BirthdayPageState createState() => BirthdayPageState();
}

class BirthdayPageState extends State<BirthdayPage> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<BirthdayBloc, BirthdayState>(
      builder: (context, state) {
        if (state is EmptyBirthdayState) {
          return BirthdayPageShimmer();
        } else if (state is LoadingBirthdayState) {
          return BirthdayPageShimmer();
        } else if (state is LoadedBirthdayState) {
          return BirthdayPageBody(
              listModel: state.birthdays,
              title: state.title,
              hasReachedMax: state.hasReachedMax
          );
        } else if (state is ErrorBirthdayState) {
          return BirthdayPageShimmer();
        }
        return BirthdayPageShimmer();
      },
      listener: (context, state) {},
    );
  }
}

class BirthdayPageBody extends StatelessWidget {
  final List<BirthdayModel> listModel;
  final String title;
  final bool hasReachedMax;

  BirthdayPageBody({
    this.listModel,
    this.title,
    this.hasReachedMax,
  });

  @override
  Widget build(BuildContext context) {
    if(listModel.length == 0){
      return Center(child: Text('По вашему запросу ничего не было найдено'),);
    }
    return RefreshLoadedWidget.smartRefresh(
        enableControlRefresh: true,
        enableControlLoad: true,
        onRefresh: () => BlocProvider.of<BirthdayBloc>(context).add(UpdateBirthdayEvent()),
        onLoading: () => BlocProvider.of<BirthdayBloc>(context).add(FetchBirthdayEvent()),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      title,
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
                return BirthdayListWidget(
                    birthdayModel: listModel[index]
                );
              },
                  childCount: listModel.length
              ),
            ),
          ],
        )
    );
  }
}

class BirthdayListWidget extends StatelessWidget {
  final BirthdayModel birthdayModel;

  BirthdayListWidget({
    @required this.birthdayModel
  }) : assert(birthdayModel != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            dense: true,
            title: Text(
                '${birthdayModel.lastName} ${birthdayModel.firstName} ${birthdayModel.fatherName}',
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    color: Color.fromRGBO(69, 69, 69, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                )
            ),
            subtitle: Text(
                birthdayModel.positionName,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    color: Color.fromRGBO(119, 134, 147, 1),
                    fontSize: 14
                )
            ),
            leading: CircleAvatar(
                foregroundColor: Colors.red,
                //radius: 60.0,
                backgroundColor: Colors.white,
                //backgroundImage: NetworkImage('https://dollarquiltingclub.com/wp-content/uploads/2018/09/noPhoto.png'),
              child: Image.asset('assets/images/noPhoto.png')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                width: 0.8,
                color: Colors.grey[400],
              ))
          ),
        )
      ],
    );
  }
}