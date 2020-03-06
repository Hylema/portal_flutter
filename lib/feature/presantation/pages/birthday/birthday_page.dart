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

        } else if (state is LoadingBirthdayState) {

        } else if (state is LoadedBirthdayState) {
          return BirthdayPageBody(data: state.model.birthdays);
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
                  'Authorization': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSIsImtpZCI6IkhsQzBSMTJza3hOWjFXUXdtak9GXzZ0X3RERSJ9.eyJhdWQiOiJodHRwczovL21ldGFsbG9pbnZlc3Quc2hhcmVwb2ludC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIvIiwiaWF0IjoxNTgzNDk2MTE5LCJuYmYiOjE1ODM0OTYxMTksImV4cCI6MTU4MzUwNzIxOSwiYWNyIjoiMSIsImFpbyI6IjQyTmdZSkRKUHlsb2JlVmhrSFJMVVBQZW1XOThiMU1lM3BjNVBzbmVVbkI1YkdHRHFTOEEiLCJhbXIiOlsid2lhIl0sImFwcF9kaXNwbGF5bmFtZSI6Ik1pLXBvcnRhbC1yZWdpc3RyYXRpb24iLCJhcHBpZCI6IjBjZjNmMTc3LTZkMzItNDQwYy1hNGUyLTA4Y2M4NGRiYzNiYiIsImFwcGlkYWNyIjoiMSIsImZhbWlseV9uYW1lIjoi0KjQsNC70LDQudC60LjQvSIsImdpdmVuX25hbWUiOiLQk9C70LXQsSDQndC40LrQvtC70LDQtdCy0LjRhyIsImluX2NvcnAiOiJ0cnVlIiwiaXBhZGRyIjoiMTg4LjQzLjEuMTAxIiwibmFtZSI6ItCo0LDQu9Cw0LnQutC40L0g0JPQu9C10LEg0J3QuNC60L7Qu9Cw0LXQstC40YciLCJvaWQiOiIwNmY3ODQ1OC04ZTgzLTQ0YmYtYTBiZi1iZjZhYzgzOTI5NzciLCJvbnByZW1fc2lkIjoiUy0xLTUtMjEtMjA3MDU5NzEwOS02MzgwMTE1NjktMTg3Mzc2NzkwMC0xNjU0NiIsInB1aWQiOiIxMDAzMjAwMDY3ODk5OTZDIiwic2NwIjoiQWxsU2l0ZXMuV3JpdGUgTXlGaWxlcy5SZWFkIFRlcm1TdG9yZS5SZWFkLkFsbCBVc2VyLlJlYWQgVXNlci5SZWFkLkFsbCIsInNpZCI6ImI3ZDg3NzNkLTk5MGMtNDVjMy05ZjIzLTE0ZTFhNTU3ZGMwZCIsInN1YiI6Img3Q3JvdDZma0dpQ0hfQzNPTTBNc0V6VUhHSjVvcTBfR3pfOTFidmV5OVkiLCJ0aWQiOiIxMmY2YWQ0NC1kMWJhLTQxMGYtOTdkNC02Yzk2NmUzODQyMWIiLCJ1bmlxdWVfbmFtZSI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInVwbiI6Imcuc2hhbGFpa2luQGpzYS1ncm91cC5ydSIsInV0aSI6IlZHa3IwN2Vvd1VLVkVGY1RTNHNsQUEiLCJ2ZXIiOiIxLjAifQ.rBR-_cfQgFXSzjk7SyTmuGZ38ECIj3z7EYguG407NpZ4gWhU62ZY4PqCUM2CZ6K56soU0Xo7Dl5283LRMO7lw7Wk9aH9SXQWq7onuNNvb_d-_BPKhzOjTcD1Sn8ZnY5ktc6vO3kCdMFq65knO28JrACeJexTUMWxIi5vqUHEifAHs34NNe2xEGDcPMxLw3IVbuI9-7pKAuadtPl2PkgdYyca-wgnhg_ynbs36EXbQLSlrr9d46zP0B3l6uDCKw9DQDcP_7liK3F2S9J_sDQ5NlUmLsxOfsf7l9ZGlcSPN588nEiBebcr5LLthXXYy9SRl0LuBfqiAgZlfSCq3Ufa3w'
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