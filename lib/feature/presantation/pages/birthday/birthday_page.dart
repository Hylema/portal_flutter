import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/mixins/blocs_dispatches_events.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdayPage extends StatefulWidget {

  @override
  BirthdayPageState createState() => BirthdayPageState();
}

class BirthdayPageState extends State<BirthdayPage> with Dispatch{

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

//    return BlocListener<BirthdayBloc, BirthdayState>(
//        listener: (context, state) {
//          if(state is LoadedBirthdayState) {
//            print('ДОБАВЛЯЮ ================ ${state.model.birthdays}');
//            setState(() {
//              data.add(state.model.birthdays);
//            });
//          }
//        },
//      child: BirthdayPageBody(data: data),
//    );
    return BlocConsumer<BirthdayBloc, BirthdayState>(
      builder: (context, state) {
        if (state is EmptyBirthdayState) {
          return BirthdayPageShimmer();
        } else if (state is LoadingBirthdayState) {
          return BirthdayPageShimmer();
        } else if (state is LoadedBirthdayState) {
          return BirthdayPageBody(data: state.model.birthdays, titleData: state.titleDate);
        } else if (state is ErrorBirthdayState) {
          return BirthdayPageShimmer();
        }
        return BirthdayPageShimmer();
      },
      listener: (context, state) {},
    );
  }
}

class BirthdayPageBody extends StatelessWidget with Dispatch {
  final List data;
  final String titleData;

  BirthdayPageBody({
    this.data,
    this.titleData,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
        enableControlLoad: true,
        enableControlRefresh: true,
        onRefresh: () => dispatchUpdateBirthday(),
        onLoading: () => dispatchLoadMoreBirthday(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      titleData,
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
                return BuildBirthdayPageBody(
                    data: data[index]
                );
              },
                  childCount: data.length
              ),
            ),
          ],
        )
    );
  }
}

class BuildBirthdayPageBody extends StatelessWidget {
  final Map data;
  BuildBirthdayPageBody({
    @required this.data
  }) {
    assert(data != null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            dense: true,
            title: Text(
                '${data['lastName']} ${data['firstName']} ${data['fatherName']}',
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
                data['positionName'],
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
                backgroundImage: NetworkImage('https://dollarquiltingclub.com/wp-content/uploads/2018/09/noPhoto.png')
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