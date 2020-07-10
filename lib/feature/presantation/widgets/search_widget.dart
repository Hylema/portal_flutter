import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function onTap;
  final Function onSubmitted;
  final Function onChanged;
  final Function clearSearch;
  final FocusNode focusNode;

  SearchWidget({
    @required this.textEditingController,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.clearSearch,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          child: Icon(Icons.search, color: Colors.grey,),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: focusNode,
                            controller: textEditingController,
                            onTap: onTap,
                            onSubmitted: onSubmitted,
                            onChanged: (value) => onChanged(value),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Поиск',
                              suffixIcon: textEditingController.text.length > 0
                                  ? IconButton(
                                onPressed: clearSearch,
                                icon: Icon(
                                  Icons.cancel,
                                  size: 14,
                                  color: Colors.grey[400],
                                ),
                              ) : IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.mic,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              )
          ),
        ),
        AnimatedCrossFade(
          crossFadeState: focusNode.hasFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          //alwaysIncludeSemantics: true,
          duration: Duration(milliseconds: 200),
          firstChild: GestureDetector(
            onTap: () => focusNode.unfocus(),
            child: Padding(
                child: Text(
                  'Отменить',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16
                  ),
                ),
                padding: EdgeInsets.only(right: 15)),
          ),
          secondChild: SizedBox(height: 0, width: 0,),
        ), Container(),
      ],
    );
  }
}