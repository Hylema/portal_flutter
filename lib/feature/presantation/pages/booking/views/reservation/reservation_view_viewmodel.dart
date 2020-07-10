//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
//import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
//import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
//import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
//import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
//import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
//import 'package:flutter_architecture_project/feature/presantation/mixins/modalSheets/booking_add_user_model_sheet.dart';
//import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/pickersModels/date_picker_birthday_model.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter_picker/flutter_picker.dart';
//import 'package:get_it/get_it.dart';
//import 'package:intl/intl.dart';
//import 'package:stacked/stacked.dart';
//
//class ReservationViewModel extends BaseViewModel with BookingAddUserModelSheet{
//  final BookingBloc bloc;
//  final getIt = GetIt.instance;
//  final NavigatorState navigator;
//  ReservationViewModel({@required this.bloc, @required this.navigator});
//
//  Storage storage;
//  bool disable = true;
//  bool meetingTitleValidation = true;
//  String externalParticipants;
//  String internalParticipants;
//  ReservationParams reservationParams;
//  CurrentBookingParams bookingParams;
//
//  DateTime currentStartTime;
//  DateTime currentEndTime;
//
//  TextEditingController date = TextEditingController();
//  TextEditingController meetingRoom = TextEditingController();
//  TextEditingController responsible = TextEditingController();
//
//  TextEditingController timeStart = TextEditingController();
//  TextEditingController timeEnd = TextEditingController();
//  TextEditingController meetingTopic = TextEditingController();
//  TextEditingController meetingType = TextEditingController();
//  TextEditingController equipment = TextEditingController();
//
//  void onPressed() {
//    bloc.add(CreateBookingEvent());
//    navigator.pop();
//  }
//
//  void onModelReady() {
//    storage = getIt<Storage>();
//    final CurrentUserModel currentUser = storage.currentUserModel;
//    final BookingState currentState = bloc.state;
//
//
//
//
//
//
//
//    if(currentState is LoadedCurrentBookingsState){
//      reservationParams = currentState.reservationParams;
//      bookingParams = currentState.currentBookingParams;
//      reservationParams.initiatorId = currentUser.id;
//      reservationParams.responsibleId = currentUser.id;
//
//      externalParticipants = reservationParams.externalParticipants.length > 0 ? '${reservationParams.externalParticipants.length}' : 'Нет участников';
//      internalParticipants = reservationParams.internalParticipants.length > 0 ? '${reservationParams.internalParticipants.length}' : 'Нет участников';
//
//      equipment.text = ((reservationParams.projector == true ? 'Проектор': '') + (reservationParams.projector == true ? reservationParams.videoStaff == true ? ', Конференц-связь' : '' : reservationParams.videoStaff == true ? 'Конференц-связь' : ''));
//
//      DateTime time = DateTime.parse(currentState.currentBookingParams.date);
//      date.text = DateFormat('dd MMMM yyyy г.').format(time);
//
//      meetingRoom.text = currentState.reservationParams.roomTitle;
//      responsible.text = reservationParams.responsibleName ?? currentUser.name;
//      timeStart.text = reservationParams.startDate != null ? DateFormat('HH:mm').format(DateTime.parse(reservationParams.startDate)) : '';
//      timeEnd.text = reservationParams.endDate != null ? DateFormat('HH:mm').format(DateTime.parse(reservationParams.endDate)) : '';
//      meetingTopic.text = reservationParams.title ?? '';
//      meetingType.text = reservationParams.meetingTypeText ?? '';
//
//      currentStartTime = reservationParams.startDate != null ? DateTime.parse(reservationParams.startDate) : DateTime.now();
//      currentEndTime = reservationParams.endDate != null ? DateTime.parse(reservationParams.endDate) : DateTime.now();
//
//      check();
//    }
//  }
//
//  void check() {
//    if(reservationParams.isReady()) disable = false;
//    else disable = true;
//
//    notifyListeners();
//  }
//
//  void onChangedMeetingTitle(String value) {
//    if(value.length >= 6) {
//      reservationParams.title = value;
//      meetingTitleValidation = true;
//    }
//    else meetingTitleValidation = false;
//
//    check();
//  }
//
//  void throwTimeStart() {
//    timeStart.text = '';
//    reservationParams.startDate = null;
//    currentStartTime = DateTime.now();
//
//    check();
//  }
//
//  void throwTimeEnd() {
//    timeEnd.text = '';
//    reservationParams.endDate = null;
//    currentEndTime = DateTime.now();
//
//    check();
//  }
//
//  void throwResponsible() {
//    responsible.text = '';
//    reservationParams.responsibleId = null;
//
//    check();
//  }
//
//  void throwMeetingTopic() {
//    meetingTopic.text = '';
//    reservationParams.meetingType = null;
//
//    check();
//  }
//
//  void throwMeetingType() {
//    meetingType.text = '';
//    reservationParams.meetingTypeId = null;
//
//    check();
//  }
//
//  void startTimePicker(BuildContext context) {
//    DatePicker.showTimePicker(
//      context,
//      showTitleActions: true,
//      showSecondsColumn: false,
//      onChanged: (date) {},
//      currentTime: currentStartTime,
//      onConfirm: (result) {
//        currentStartTime = result;
//        timeStart.text = DateFormat('HH:mm').format(result);
//        reservationParams.startDate = bookingParams.date + 'T' + DateFormat('HH:mm:').format(result) + '00Z';
//
//        check();
//      },
//      locale: LocaleType.ru,
//    );
//  }
//
//  void showModal(BuildContext context){
//    showModalSheet(context: context, isSolo: true, title: 'Выбрать ответственного', reservationPageBloc: bloc);
//  }
//
//  void endTimePicker(BuildContext context) {
////    return await Navigator.push(
////        context,
////        new DatePickerRoute(
////            showTitleActions: showTitleActions,
////            onChanged: onChanged,
////            onConfirm: onConfirm,
////            onCancel: onCancel,
////            locale: locale,
////            theme: theme,
////            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
////            pickerModel: TimePickerModel(
////                currentTime: currentTime, locale: locale, showSecondsColumn: showSecondsColumn)));
//
//    DatePicker.showTimePicker(
//      context,
//      showTitleActions: true,
//      showSecondsColumn: false,
//      onChanged: (date) {},
//      currentTime: currentEndTime,
//      onConfirm: (DateTime result) {
//        currentEndTime = result;
//        timeEnd.text = DateFormat('HH:mm').format(result);
//        reservationParams.endDate = bookingParams.date + 'T' + DateFormat('HH:mm:').format(result) + '00Z';
//
//        check();
//      },
//      locale: LocaleType.ru,
//    );
//  }
//
//  void meetingTypePicker(BuildContext context) =>
//      Picker(
//          adapter: PickerDataAdapter<String>(pickerdata: reservationParams.meetingType.map((MeetingTypeModel meetingTypeModel) => meetingTypeModel.title).toList()),
//          cancelText: 'Отмена',
//          cancelTextStyle: TextStyle(color: Colors.grey, fontSize: 16),
//          confirmText: 'Готово',
//          confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
//          magnification: 1.0,
//          diameterRatio: 1.6,
//          squeeze: 1.0,
//          itemExtent: 30.0,
//          headerDecoration: BoxDecoration(
//              color: Colors.white
//          ),
//          changeToFirst: true,
//          textAlign: TextAlign.left,
//          columnPadding: const EdgeInsets.all(8.0),
//          onConfirm: (Picker picker, List<int> value) {
//            meetingType.text = picker.getSelectedValues()[0].toString();
//            reservationParams.meetingTypeText = meetingType.text;
//            reservationParams.meetingTypeId = (value[0] + 1).toString();
//            check();
//          }
//      ).showModal(context);
//
////  void equipmentPicker(BuildContext context) =>
////      Picker(
////          adapter: PickerDataAdapter<String>(pickerdata: ['Не требуется', 'Проектор', 'Конференц-связь']),
////          cancelText: 'Отмена',
////          cancelTextStyle: TextStyle(color: Colors.grey, fontSize: 16),
////          confirmText: 'Готово',
////          confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
////          magnification: 1.0,
////          diameterRatio: 1.6,
////          squeeze: 1.0,
////          itemExtent: 30.0,
////          headerDecoration: BoxDecoration(
////              color: Colors.white
////          ),
////          changeToFirst: true,
////          textAlign: TextAlign.left,
////          columnPadding: const EdgeInsets.all(8.0),
////          onConfirm: (Picker picker, List value) {
////            equipment.text = picker.getSelectedValues()[0].toString();
////            notifyListeners();
////          }
////      ).showModal(context);
//}
//
//
//class DatePickerRoute<T> extends PopupRoute<T> {
//  DatePickerRoute({
//    this.showTitleActions,
//    this.onChanged,
//    this.onConfirm,
//    this.onCancel,
//    theme,
//    this.barrierLabel,
//    this.locale,
//    RouteSettings settings,
//    pickerModel,
//  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
//        this.theme = theme ?? DatePickerTheme(),
//        super(settings: settings);
//
//  final bool showTitleActions;
//  final DateChangedCallback onChanged;
//  final DateChangedCallback onConfirm;
//  final DateCancelledCallback onCancel;
//  final DatePickerTheme theme;
//  final LocaleType locale;
//  final BasePickerModel pickerModel;
//
//  @override
//  Duration get transitionDuration => const Duration(milliseconds: 200);
//
//  @override
//  bool get barrierDismissible => true;
//
//  @override
//  final String barrierLabel;
//
//  @override
//  Color get barrierColor => Colors.black54;
//
//  AnimationController _animationController;
//
//  @override
//  AnimationController createAnimationController() {
//    assert(_animationController == null);
//    _animationController = BottomSheet.createAnimationController(navigator.overlay);
//    return _animationController;
//  }
//
//  @override
//  Widget buildPage(
//      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//    Widget bottomSheet = new MediaQuery.removePadding(
//      context: context,
//      removeTop: true,
//      child: _DatePickerComponent(
//        onChanged: onChanged,
//        locale: this.locale,
//        route: this,
//        pickerModel: pickerModel,
//      ),
//    );
//    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
//    if (inheritTheme != null) {
//      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
//    }
//    return bottomSheet;
//  }
//}
//
//class _DatePickerComponent extends StatefulWidget {
//  _DatePickerComponent(
//      {Key key, @required this.route, this.onChanged, this.locale, this.pickerModel});
//
//  final DateChangedCallback onChanged;
//
//  final DatePickerRoute route;
//
//  final LocaleType locale;
//
//  final BasePickerModel pickerModel;
//
//  @override
//  State<StatefulWidget> createState() {
//    return _DatePickerState();
//  }
//}
//
//class _DatePickerState extends State<_DatePickerComponent> {
//  FixedExtentScrollController leftScrollCtrl, middleScrollCtrl, rightScrollCtrl;
//
//  @override
//  void initState() {
//    super.initState();
//    refreshScrollOffset();
//  }
//
//  void refreshScrollOffset() {
////    print('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');
//    leftScrollCtrl =
//    new FixedExtentScrollController(initialItem: widget.pickerModel.currentLeftIndex());
//    middleScrollCtrl =
//    new FixedExtentScrollController(initialItem: widget.pickerModel.currentMiddleIndex());
//    rightScrollCtrl =
//    new FixedExtentScrollController(initialItem: widget.pickerModel.currentRightIndex());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    DatePickerTheme theme = widget.route.theme;
//    return GestureDetector(
//      child: AnimatedBuilder(
//        animation: widget.route.animation,
//        builder: (BuildContext context, Widget child) {
//          final double bottomPadding = MediaQuery.of(context).padding.bottom;
//          return ClipRect(
//            child: CustomSingleChildLayout(
//              delegate: _BottomPickerLayout(widget.route.animation.value, theme,
//                  showTitleActions: widget.route.showTitleActions, bottomPadding: bottomPadding),
//              child: GestureDetector(
//                child: Material(
//                  color: theme.backgroundColor ?? Colors.white,
//                  child: _renderPickerView(theme),
//                ),
//              ),
//            ),
//          );
//        },
//      ),
//    );
//  }
//
//  void _notifyDateChanged() {
//    if (widget.onChanged != null) {
//      widget.onChanged(widget.pickerModel.finalTime());
//    }
//  }
//
//  Widget _renderPickerView(DatePickerTheme theme) {
//    Widget itemView = _renderItemView(theme);
//    if (widget.route.showTitleActions) {
//      return Column(
//        children: <Widget>[
//          _renderTitleActionsView(theme),
//          itemView,
//        ],
//      );
//    }
//    return itemView;
//  }
//
//  Widget _renderColumnView(
//      ValueKey key,
//      DatePickerTheme theme,
//      StringAtIndexCallBack stringAtIndexCB,
//      ScrollController scrollController,
//      int layoutProportion,
//      ValueChanged<int> selectedChangedWhenScrolling,
//      ValueChanged<int> selectedChangedWhenScrollEnd) {
//    return Expanded(
//      flex: layoutProportion,
//      child: Container(
//          padding: EdgeInsets.all(8.0),
//          height: theme.containerHeight,
//          decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
//          child: NotificationListener(
//              onNotification: (ScrollNotification notification) {
//                if (notification.depth == 0 &&
//                    selectedChangedWhenScrollEnd != null &&
//                    notification is ScrollEndNotification &&
//                    notification.metrics is FixedExtentMetrics) {
//                  final FixedExtentMetrics metrics = notification.metrics;
//                  final int currentItemIndex = metrics.itemIndex;
//                  selectedChangedWhenScrollEnd(currentItemIndex);
//                }
//                return false;
//              },
//              child: CupertinoPicker.builder(
//                  key: key,
//                  backgroundColor: theme.backgroundColor ?? Colors.white,
//                  scrollController: scrollController,
//                  itemExtent: theme.itemHeight,
//                  onSelectedItemChanged: (int index) {
//                    selectedChangedWhenScrolling(index);
//                  },
//                  useMagnifier: true,
//                  itemBuilder: (BuildContext context, int index) {
//                    final content = stringAtIndexCB(index);
//                    if (content == null) {
//                      return null;
//                    }
//                    return Container(
//                      height: theme.itemHeight,
//                      alignment: Alignment.center,
//                      child: Text(
//                        content,
//                        style: theme.itemStyle,
//                        textAlign: TextAlign.start,
//                      ),
//                    );
//                  }))),
//    );
//  }
//
//  Widget _renderItemView(DatePickerTheme theme) {
//    return Container(
//      color: theme.backgroundColor ?? Colors.white,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Container(
//            child: widget.pickerModel.layoutProportions()[0] > 0
//                ? _renderColumnView(
//                ValueKey(widget.pickerModel.currentLeftIndex()),
//                theme,
//                widget.pickerModel.leftStringAtIndex,
//                leftScrollCtrl,
//                widget.pickerModel.layoutProportions()[0], (index) {
//              widget.pickerModel.setLeftIndex(index);
//            }, (index) {
//              setState(() {
//                refreshScrollOffset();
//                _notifyDateChanged();
//              });
//            })
//                : null,
//          ),
//          Text(
//            widget.pickerModel.leftDivider(),
//            style: theme.itemStyle,
//          ),
//          Container(
//            child: widget.pickerModel.layoutProportions()[1] > 0
//                ? _renderColumnView(
//                ValueKey(widget.pickerModel.currentLeftIndex()),
//                theme,
//                widget.pickerModel.middleStringAtIndex,
//                middleScrollCtrl,
//                widget.pickerModel.layoutProportions()[1], (index) {
//              widget.pickerModel.setMiddleIndex(index);
//            }, (index) {
//              setState(() {
//                refreshScrollOffset();
//                _notifyDateChanged();
//              });
//            })
//                : null,
//          ),
//          Text(
//            widget.pickerModel.rightDivider(),
//            style: theme.itemStyle,
//          ),
//          Container(
//            child: widget.pickerModel.layoutProportions()[2] > 0
//                ? _renderColumnView(
//                ValueKey(widget.pickerModel.currentMiddleIndex() * 100 +
//                    widget.pickerModel.currentLeftIndex()),
//                theme,
//                widget.pickerModel.rightStringAtIndex,
//                rightScrollCtrl,
//                widget.pickerModel.layoutProportions()[2], (index) {
//              widget.pickerModel.setRightIndex(index);
//              _notifyDateChanged();
//            }, null)
//                : null,
//          ),
//        ],
//      ),
//    );
//  }
//
//  // Title View
//  Widget _renderTitleActionsView(DatePickerTheme theme) {
//    String done = _localeDone();
//    String cancel = _localeCancel();
//
//    return Container(
//      height: theme.titleHeight,
//      decoration: BoxDecoration(
//        color: theme.headerColor ?? theme.backgroundColor ?? Colors.white,
//      ),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Container(
//            height: theme.titleHeight,
//            child: CupertinoButton(
//              pressedOpacity: 0.3,
//              padding: EdgeInsets.only(left: 16, top: 0),
//              child: Text(
//                '$cancel',
//                style: theme.cancelStyle,
//              ),
//              onPressed: () {
//                Navigator.pop(context);
//                if (widget.route.onCancel != null) {
//                  widget.route.onCancel();
//                }
//              },
//            ),
//          ),
//          Container(
//            height: theme.titleHeight,
//            child: CupertinoButton(
//              pressedOpacity: 0.3,
//              padding: EdgeInsets.only(right: 16, top: 0),
//              child: Text(
//                '$done',
//                style: theme.doneStyle,
//              ),
//              onPressed: () {
//                Navigator.pop(context, widget.pickerModel.finalTime());
//                if (widget.route.onConfirm != null) {
//                  widget.route.onConfirm(widget.pickerModel.finalTime());
//                }
//              },
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  String _localeDone() {
//    return i18nObjInLocale(widget.locale)['done'];
//  }
//
//  String _localeCancel() {
//    return i18nObjInLocale(widget.locale)['cancel'];
//  }
//}
//
//class _BottomPickerLayout extends SingleChildLayoutDelegate {
//  _BottomPickerLayout(this.progress, this.theme,
//      {this.itemCount, this.showTitleActions, this.bottomPadding = 0});
//
//  final double progress;
//  final int itemCount;
//  final bool showTitleActions;
//  final DatePickerTheme theme;
//  final double bottomPadding;
//
//  @override
//  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
//    double maxHeight = theme.containerHeight;
//    if (showTitleActions) {
//      maxHeight += theme.titleHeight;
//    }
//
//    return new BoxConstraints(
//        minWidth: constraints.maxWidth,
//        maxWidth: constraints.maxWidth,
//        minHeight: 0.0,
//        maxHeight: maxHeight + bottomPadding);
//  }
//
//  @override
//  Offset getPositionForChild(Size size, Size childSize) {
//    double height = size.height - childSize.height * progress;
//    return new Offset(0.0, height);
//  }
//
//  @override
//  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
//    return progress != oldDelegate.progress;
//  }
//}