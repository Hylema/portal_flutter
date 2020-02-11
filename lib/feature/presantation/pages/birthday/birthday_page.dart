import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';

class BirthdayPage extends StatefulWidget {

  @override
  BirthdayPageState createState() => BirthdayPageState();
}

class BirthdayPageState extends State<BirthdayPage> {

  bool checker = true;

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2021, 1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then((onValue) {
      setState(() {
        checker = false;
      });
    });
    return Builder(
        builder: (BuildContext context){
          if(checker){
            return BirthdayPageShimmer();
          }

          List data = [
            {
              'birthday': '27.12.2019',
              'name': 'Арнольд Шварценеггер',
              'position': 'Ведущий бодибилдер',
              'photo': 'https://w-dog.ru/wallpapers/4/18/283656687472605/arnold-shvarcenegger-gubernator-cherno-belyj.jpg'
            },
          ];

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
                    return _buildLine(data[index]['birthday'], data[index]['name'], data[index]['position'], data[index]['photo'],);
                  },
                      childCount: 1
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
  Widget _buildLine(
      String birthday,
      String name,
      String position,
      String photo,
      ){
    return Container(
      child: ListTile(
        title: Text(name, style: TextStyle(color: Color.fromRGBO(69, 69, 69, 1), fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(position, style: TextStyle(color: Color.fromRGBO(119, 134, 147, 1), fontSize: 14)),
        leading: Container(
          height: 55,
          width: 55,
          child: CircleAvatar(
            foregroundColor: Colors.red,
            //radius: 60.0,
            backgroundColor: Color(0xFF778899),
            backgroundImage: NetworkImage(
              photo,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: Colors.grey[400],
          ))
      ),
    );
  }
}