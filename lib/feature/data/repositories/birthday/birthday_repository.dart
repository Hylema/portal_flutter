import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/birthday/birthday_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params_response.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/birthday/birthday_repository_interface.dart';

import 'package:meta/meta.dart';

class BirthdayRepository implements IBirthdayRepository{
  final BirthdayRemoteDataSource remoteDataSource;
  final BirthdayLocalDataSource localDataSource;

  BirthdayRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<BirthdayResponse> fetchBirthday({
    @required BirthdayParams params,
    bool update = false
  }) async {
    final BirthdayResponse _response = await _getData(params: params);

    if(update) await updateBirthdayCache(response: _response);
    else await saveBirthdayToCache(response: _response);

    return _response;
  }

  @override
  BirthdayResponse getBirthdayFromCache() =>
      localDataSource.getBirthdayFromCache();

  @override
  Future<void> saveBirthdayToCache({@required BirthdayResponse response}) async =>
      await localDataSource.saveBirthdayToCache(response: response);

  @override
  Future<void> updateBirthdayCache({@required BirthdayResponse response}) async =>
      await localDataSource.updateBirthdayCache(response: response);

  Future<BirthdayResponse> _getData({@required BirthdayParams params}) async {
    final month = [
      'Января','Ферваля','Марта',
      'Апреля','Мая','Июня',
      'Июля','Августа','Сентября',
      'Октября','Ноября','Декабря'
    ];

    String _title;
    List<BirthdayModel> _listModels;

    if(params.dayNumber != null && params.monthNumber != null){
      _title = 'Поиск ${params.dayNumber} ${month[params.monthNumber - 1]}';

      _listModels = await remoteDataSource.getConcreteDayBirthdayWithParams(birthdayParams: params);

    } else {
      _listModels = await remoteDataSource.getStartEndDayBirthdayWithParams(birthdayParams: params);

      if(params.startDayNumber != null && params.startMonthNumber != null){
        _title = 'Поиск с ${params.startDayNumber} ${month[params.startMonthNumber - 1]}';
      }

      if(params.endDayNumber != null && params.endMonthNumber != null){
        _title = 'Поиск по ${params.endDayNumber} ${month[params.endMonthNumber - 1]}';
      }

      if(params.startDayNumber != null && params.startMonthNumber != null && params.endDayNumber != null && params.endMonthNumber != null){
        _title = 'Поиск c ${params.startDayNumber} ${month[params.startMonthNumber - 1]} по ${params.endDayNumber} ${month[params.endMonthNumber - 1]}';
      }
    }

    return BirthdayResponse(
      title: _title,
      listModels: _listModels
    );
  }
}
