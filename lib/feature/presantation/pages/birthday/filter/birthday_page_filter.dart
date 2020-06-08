import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/fade_animation.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/filter/birthday_page_filter_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class BirthdayPageFilter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BirthdayPageFilterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () => model.goBack(),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            title: Text('Параметры', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [
              MaterialButton(
                  onPressed: () => model.throwFilters(),
                  child: Text('Сбросить', style: TextStyle(color: Colors.lightBlue, fontSize: 16),)
              ),
            ]
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              TextField(
                                controller: model.fio,
                                decoration: InputDecoration(
                                    labelText: "ФИО",
                                    suffixIcon: model.fio.text.length > 0
                                        ? IconButton(
                                      onPressed: () => model.throwFioFilter(),
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 14,
                                        color: Colors.grey[400],
                                      ),
                                    )
                                        : null
                                ),
//                                onChanged: (value) {
//                                  setState(() {
//                                    _checkFields();
//                                  });
//                                },
                              ),
                              TextField(
                                enabled: !model.disableConcreteData,
                                controller: model.concreteDate,
                                readOnly: true,
                                onTap: () => model.concreteDatePicker(context),
                                decoration: InputDecoration(
                                    labelText: "Дата",
                                    suffixIcon: model.concreteDate.text.length > 0
                                        ? IconButton(
                                      onPressed: () => model.throwConcreteDateFilter(),
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 14,
                                        color: Colors.grey[400],
                                      ),
                                    )
                                        : null
                                ),
                              ),
                              TextField(
                                enabled: !model.disablePeriodFromBy,
                                controller: model.periodFrom,
                                readOnly: true,
                                onTap: () => model.fromDatePicker(context),
                                decoration: InputDecoration(
                                    labelText: "Период с",
                                    suffixIcon: model.periodFrom.text.length > 0
                                        ? IconButton(
                                      onPressed: () => model.throwFromDateFilter(),
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 14,
                                        color: Colors.grey[400],
                                      ),
                                    )
                                        : null
                                ),
                              ),
                              TextField(
                                enabled: !model.disablePeriodFromBy,
                                controller: model.periodBy,
                                readOnly: true,
                                onTap: () => model.byDatePicker(context),
                                decoration: InputDecoration(
                                    labelText: "Период по",
                                    suffixIcon: model.periodBy.text.length > 0
                                        ? IconButton(
                                      onPressed: () => model.throwByDateFilter(),
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 14,
                                        color: Colors.grey[400],
                                      ),
                                    )
                                        : null
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: RaisedButton(
                                  disabledColor: Color.fromRGBO(238, 0, 38, 0.48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text('Показать', style: TextStyle(color: Colors.white)),
                                  ),
                                  onPressed: model.disable ? null : () => model.applyFilter(),
                                  color: Color.fromRGBO(238, 0, 38, 1)
                              )
                          ),
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/6,
                  ),
                ])
            )
          ],
        ),
      ),
      viewModelBuilder: () => BirthdayPageFilterViewModel(
        navigation: Navigator.of(context)
      ),
    );
  }
}