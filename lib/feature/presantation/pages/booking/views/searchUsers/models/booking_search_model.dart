import 'dart:async';

import 'package:flutter/cupertino.dart';

class BookingSearchModel {
  TextEditingController textEditingController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  Timer debounce;
}