import 'dart:convert';

import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/datasources/news/news_portal_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/news_portal_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';


class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NewsPortalLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NewsPortalLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const String CACHED_NUMBER_TRIVIA = 'CACHED_NEWS_PORTAL';

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
    NewsPortalModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
          () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await dataSource.getLastNewsPortal();
        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      // Not calling the method here, just storing it inside a call variable
      final call = dataSource.getLastNewsPortal;
      // assert

      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheNewsPortal', () {
    final tNewsPortalModel =
    NewsPortalModel(news: 'test trivia');

    test('should call SharedPreferences to cache the data', () {
      // act
      dataSource.cacheNewsPortal(tNewsPortalModel);
      // assert
      final expectedJsonString = json.encode(tNewsPortalModel.toJson());

      verify(mockSharedPreferences.setString(
        CACHED_NUMBER_TRIVIA,
        expectedJsonString,
      ));
    });
  });
}