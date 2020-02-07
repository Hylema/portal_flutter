import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_parametrs.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/action_button_navigation_bar_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/main_floating_action_button_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_model_sheet_widget.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultBottomBarController(
      dragLength: 500,
      snap: true,
      child: Page(),
    );
  }
}

class Page extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PageState();
}
class PageState extends State<Page> {
  int _selectedTab = 0;

  var _headerOptions;
  var _pageOptions;
  @override
  void initState(){
    super.initState();

    _pageOptions = [
      MainPage(updateIndex: _updateIndex),
      NewsPortalPage(),
      ProfilePage(),
      NewsPortalPage(),
      BirthdayPage()
    ];

    _headerOptions = [
      HeaderAppMainBar(
        titleText: 'Главная',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){},
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppMainBar(
        titleText: 'Новости холдинга',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  showModalSheet(context);
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppMainBar(
        titleText: 'Профиль',
      ),
      HeaderAppMainBar(
        titleText: 'test',
      ),
      HeaderAppMainBar(
        titleText: 'Дни рождения',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                Navigator.push(context, SlideRightRoute(page: BirthdayParametrs()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
    ];
  }

  void _updateIndex(int index){
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          constraints: BoxConstraints(maxWidth: 100),
          color: Colors.green,
          child: Scaffold(
            extendBody: true,
            appBar: _headerOptions[_selectedTab],
            body: _pageOptions[_selectedTab],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: MainFloatingActionButtonWidget(),
            bottomNavigationBar: ActionButtonNavigationBarWidget(
              selectedIndex: _selectedTab,
              updateIndex: _updateIndex,
            ),
          ),
        )
    );
  }
}