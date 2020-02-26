import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
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

        } else if (state is LoadingBirthdayState) {

        } else if (state is LoadedBirthdayState) {
          return BirthdayPageBody(data: state.model.birthdays,);
        } else if (state is ErrorBirthdayState) {
        }
        return Container();
      },
      listener: (context, state) {},
    );
  }
}

class BirthdayPageBody extends StatelessWidget {
  final List data;
  BirthdayPageBody({this.data});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        child: Text(
                          'Сегодня',
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
            ),
          );
        }
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
            leading: Container(
              height: 60,
              width: 60,
              child: CircleAvatar(
                foregroundColor: Colors.red,
                //radius: 60.0,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage('https://www.thermostream.ru/images/no_photo.png'),
              ),
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