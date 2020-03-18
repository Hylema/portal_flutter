import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockMainPageWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Color background;
  final int index;

  BlockMainPageWidget({
    this.child,
    this.title,
    this.background = Colors.white,
    @required this.index
  }){
    assert(index != null);
  }

  @override
  Widget build(BuildContext context) {
    void dispatchUpdateIndex(index){
      context.bloc<SelectedIndexBloc>().add(UpdateIndexEvent(index: index));
    }

    return Container(
      color: background,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                GestureDetector(
                  child: Text(
                      'смотреть все',
                    style: TextStyle(
                      color: Color.fromRGBO(39, 131, 216, 1),
                      fontSize: 16
                    ),
                  ),
                  onTap: () {
                    dispatchUpdateIndex(index);
                  },
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 20),
            child: child
          ),
        ],
      ),
    );
  }
}