import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/calendar_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/untils/calendar_untils.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/widgets/expansion_cross_fade.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:stacked/stacked.dart';

class Calendar extends StatelessWidget {

  List events;
  Calendar({this.events});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalendarViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: model.isExpanded ? model.previousMonth : model.previousWeek,
                  icon: Icon(Icons.chevron_left),
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      child: Text('Сегодня'),
                      onTap: model.resetToToday,
                    ),
                    Text(
                      model.displayMonth,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: model.isExpanded ? model.nextMonth : model.nextWeek,
                  icon: Icon(Icons.chevron_right),
                ),
              ],
            ),
            ExpansionCrossFade(
              body: SimpleGestureDetector(
                onVerticalSwipe: (SwipeDirection swipeDirection) => model.onVerticalSwipe(swipeDirection),
                onHorizontalSwipe: (SwipeDirection swipeDirection) => model.onHorizontalSwipe(swipeDirection),
                swipeConfig: SimpleSwipeConfig(
                  verticalThreshold: 10.0,
                  horizontalThreshold: 40.0,
                ),
                child: Column(children: <Widget>[
                  GridView.count(
                    childAspectRatio: 1.5,
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    padding: EdgeInsets.only(bottom: 0.0),
                    children: model.calendarBuilder(),
                  ),
                ]),
              ),
              isExpanded: model.isExpanded,
            ),
            SimpleGestureDetector(
                onVerticalSwipe: (SwipeDirection swipeDirection) => model.onVerticalSwipe(swipeDirection),
                onTap: model.toggleExpanded,
                swipeConfig: SimpleSwipeConfig(
                  verticalThreshold: 10.0,
                ),
                child: Container(
                  color: Colors.black12,
                  height: 40,
                  margin: EdgeInsets.only(top: 8.0),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          CalendarUtils.fullDayFormat(model.selectedDate),
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 40.0),
                      IconButton(
                        onPressed: model.toggleExpanded,
                        iconSize: 25.0,
                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        icon: model.isExpanded
                            ? Icon(
                          Icons.arrow_drop_up,
                          color: Colors.black,
                        )
                            : Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Colors.black12),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                  child: ListTile(
//                    title: Text(_selectedEvents[index]['name'].toString()),
                    onTap: () {},
                  ),
                ),
                itemCount: 0,
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => CalendarViewModel(
        events: events
      ),
    );
  }
}

