import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
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
    List data = [];

    return BlocListener<BirthdayBloc, BirthdayState>(
        listener: (context, state) {
          if(state is LoadedBirthdayState) {
            setState(() {
              data.add(state.model.birthdays);
            });
          }
        },
      child: BirthdayPageBody(data: data),
    );
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
    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      pageKey: BIRTHDAY_PAGE,
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
                backgroundImage: data['photoUrl'] != null ? NetworkImage(data['photoUrl'], headers: {
                  'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgzMzg5NjA0LCJuYmYiOjE1ODMzODk2MDQsImV4cCI6MTU4MzQwMDcwNCwiYWNyIjoiMSIsImFpbyI6IjQyTmdZQ2dRdXh4ZU9PRmEyaTIrTGVFZHgyWi9TSE01dDgzWWFYRjlUMG5PdVVYekRFMEIiLCJhbXIiOlsid2lhIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInB1aWQiOiIxMDAzMjAwMDY3ODk5OTZDIiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInNpZCI6ImI3ZDg3NzNkLTk5MGMtNDVjMy05ZjIzLTE0ZTFhNTU3ZGMwZCIsInN1YiI6Img3Q3JvdDZma0dpQ0hfQzNPTTBNc0V6VUhHSjVvcTBfR3pfOTFidmV5OVkiLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6IkF6blZTNE5adDBhNXRiMEVfb2NJQUEiLCJ2ZXIiOiIxLjAifQ.TCPL1K56s90WpGMf5x-d0u-Z27SMpyrQYP7iWTsFBG39q0Ue4VY8ohmTOtT-K9AO8QrzjIVr_YebSYsn8Z8ET8Z4YhUdAOAHj4wXJtaz1gb0inzTVpX17lEDc-fENw_vGycBziQcVlGRfs_NbGLjFBxE7bVeKzZg_IdyyZHHkQEfKvy3TKDnQzaMEDUylkp9DztyB6ZpUV95FB3bPeBCtCbO85xuE5yYHa9NQrpe3X6d_eiTRpGJ6fcxHSsJZX0_ghx420SVk_OgBmuRt2VXIPBJbTgGb2ZJ1cmEuGvUojNv_TzTvP2K_JhfM1kHdvGi8XL16vajkxlqcK66jyDMng'
                })
                : NetworkImage('https://www.thermostream.ru/images/no_photo.png'),
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