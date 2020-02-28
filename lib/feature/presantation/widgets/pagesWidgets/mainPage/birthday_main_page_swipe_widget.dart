import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BirthdayMainPageSwipeWidget extends StatefulWidget {

  @override
  BirthdayMainPageSwipeWidgetState createState() => BirthdayMainPageSwipeWidgetState();
}

class BirthdayMainPageSwipeWidgetState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<BirthdayBloc, BirthdayState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is LoadedBirthdayState){
          return BirthdayMainPageSwipeWidgetStateBuild(birthdays: state.model.birthdays,);
        } else {
          return Container();
        }
      },
    );
  }
}

class BirthdayMainPageSwipeWidgetStateBuild extends StatelessWidget {

  final List birthdays;
  BirthdayMainPageSwipeWidgetStateBuild({
    @required this.birthdays
  }) {
    assert(birthdays != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Swiper(
          autoplay: true,
          autoplayDelay: 4000,
          itemBuilder: (BuildContext context, int index) {

            Map data = birthdays[index];

            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        5.0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxWidth: 130, maxHeight: 130),
                      child: Center(
                        child: Image.asset('assets/images/noPhoto.png', width: 70,),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                5.0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ),
                            )
                          ],
                          border: Border.all(
                              color: Colors.white,
                              width: 6.0
                          )
                      ),
                    ),
                    Text(
                      '${data['lastName']} ${data['firstName']} ${data['fatherName']}',
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Сегодня',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 11
                      ),
                    ),
                  ],
                )
            );
          },
          itemCount: birthdays.length,
          viewportFraction: 0.5
      ),
      height: 300,
    );
  }
}