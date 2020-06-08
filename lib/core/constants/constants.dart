import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Tokens
const String JWT_TOKEN = 'jwt_token';
const String JWT_DECODE = 'jwt_token_decode';
const String JWT_TOKEN_SECOND = 'jwt_token_second';

const String CURRENT_USER = 'current_user';

///Pages
const int MAIN_PAGE_INDEX_NUMBER = 0;
const int NEWS_PAGE_INDEX_NUMBER = 1;
const int PROFILE_PAGE_INDEX_NUMBER = 2;
const int BIRTHDAY_PAGE_INDEX_NUMBER = 3;
const int POLLS_PAGE_INDEX_NUMBER = 4;
const int VIDEO_PAGE_INDEX_NUMBER = 5;
const int PHONE_BOOK_PAGE_INDEX_NUMBER = 6;

///Different
const String UPDATE_FOOTER = 'footer';
const String UPDATE_HEADER = 'header';

const String PAGE = 'page';

///bottomNavigationBar
const double BOTTOM_NAVIGATION_BAR_ICON_SIZE = 30;
const double BOTTOM_NAVIGATION_BAR_TEXT_SIZE = 12;
const double BOTTOM_NAVIGATION_BAR_SELECTED_TEXT_SIZE = 15;
const double EXPANDABLE_APP_BAR_HORIZONTAL_MARGIN = 20;
// ignore: non_constant_identifier_names
final double EXPANDABLE_APP_BAR_HEIGHT = (EXPANDABLE_APP_BAR_ITEMS.length * 50).toDouble();
const Color BOTTOM_NAVIGATION_BAR_SELECTED_COLOR = Color.fromRGBO(238, 0, 38, 1);
const Color BOTTOM_NAVIGATION_BAR_DEFAULT_COLOR = Colors.grey;
const List APP_BAR_ITEMS = [
  {
    'icon': '${assetsIcon}home.png',
    'text': 'Главная',
  },
  {
    'icon': '${assetsIcon}news.png',
    'text': 'Новости',
  },
  {
    'icon': '${assetsIcon}profile.png',
    'text': 'Профиль',
  },
];
const List EXPANDABLE_APP_BAR_ITEMS = [
  {
    'icon': '${assetsIcon}birthday.png',
    'text': 'Дни рождения'
  },
  {
    'icon': '${assetsIcon}polls.png',
    'text': 'Опросы'
  },
  {
    'icon': '${assetsIcon}videoGallery.png',
    'text': 'Видеогалерея'
  },
  {
    'icon': '${assetsIcon}phonebook.png',
    'text': 'Телефонный справочник'
  },
  {
    'icon': '${assetsIcon}calendarEvents.png',
    'text': 'Календарь событий'
  },
  {
    'icon': '${assetsIcon}negotiationReservation.png',
    'text': 'Бронирование переговорных'
  },
  {
    'icon': '${assetsIcon}applications.png',
    'text': 'Заявки'
  },
  {
    'icon': '${assetsIcon}сorporateDocuments.png',
    'text': 'Корпоративные документы'
  },
];

///Path to assets icons
const String assetsIcon = 'assets/icons/';
const String assetsImage = 'assets/images/';

///Cache
const String CACHE_BIRTHDAY = 'cache_birthday';
const String CACHE_POSITION_PAGES = 'cache_position_pages';
const String CACHE_NEWS = 'cache_news';
const String CACHE_PROFILE = 'cache_profile';
const String CACHE_PHONE_BOOKS_CODES = 'cache_phone_books_codes';


const int BIRTHDAY_PAGE_SIZE = 15;
const int NEWS_PAGE_SIZE = 15;

///Errors
const String CACHE_EXCEPTION_MESSAGE = 'Ошибка при получении данных из кэша';
const String JSON_EXCEPTION_MESSAGE = 'Ошибка при получении данных из json';
const String NETWORK_EXCEPTION_MESSAGE = 'Ошибка при подключении к сети';
const String SERVER_EXCEPTION_MESSAGE = 'Ошибка сервера, статус код: 500';
const String BAD_REQUEST_EXCEPTION_MESSAGE = 'Ошибка, неверно переданы параметры, статус код: 400';
const String UNKNOWN_EXCEPTION_MESSAGE = 'Неизвестная ошибка';

class Routes {
  static const String welcome = '/';
  static const String auth = '/auth';
  static const String app = '/app';
}

///Main Page Position Widgets
const List DEFAULT_POSITION_PAGES = [
  {
    'title': NEWS_PAGE,
    'visible': true,
    'icon': '${assetsIcon}news.png'
  },
  {
    'title': POLLS_PAGE,
    'visible': true,
    'icon': '${assetsIcon}polls.png'
  },
  {
    'title': VIDEO_PAGE,
    'visible': true,
    'icon': '${assetsIcon}videoGallery.png'
  },
  {
    'title': BIRTHDAY_PAGE,
    'visible': false,
    'icon': '${assetsIcon}birthday.png',
  },
  {
    'title': BOOKING_PAGE,
    'visible': false,
    'icon': '${assetsIcon}negotiationReservation.png'
  },
];
const String NEWS_PAGE = 'Новости';
const String POLLS_PAGE = 'Опросы';
const String VIDEO_PAGE = 'Видеогалерея';
const String BIRTHDAY_PAGE = 'Дни рождения';
const String BOOKING_PAGE = 'Бронирование переговорных';
