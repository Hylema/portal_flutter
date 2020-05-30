import 'package:flutter/material.dart';

//class NewsPortalModelSheetWidget extends StatefulWidget {
//
//  @override
//  NewsPortalModelSheetWidgetState createState() => NewsPortalModelSheetWidgetState();
//}
//
//class NewsPortalModelSheetWidgetState extends State<NewsPortalModelSheetWidget> {
//
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}

void showModalSheet(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          )
      ),
      builder: (builder) {
        return Container(
          height: 160,
          //color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.remove,
                size: 40,
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    'assets/icons/newsHolding.png',
                  ),
                ),
                title: Text('Новости холдинга'),
                onTap: (){},
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    'assets/icons/newsCompany.png',
                  ),
                ),
                title: Text('Новости предприятия'),
                onTap: (){},
              ),
            ],
          ),
        );
      }
  );
}