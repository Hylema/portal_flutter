import 'dart:wasm';

///Tokens
const String JWT_TOKEN = 'jwt_token';
const String JWT_DECODE = 'jwt_token_decode';
const String JWT_TOKEN_SECOND = 'jwt_token_second';

///Pages
const int MAIN_PAGE_INDEX_NUMBER = 3; //0
const int NEWS_PAGE_INDEX_NUMBER = 1;
const int PROFILE_PAGE_INDEX_NUMBER = 2;
const int BIRTHDAY_PAGE_INDEX_NUMBER = 0; //3
const int POLLS_PAGE_INDEX_NUMBER = 4;
const int VIDEO_PAGE_INDEX_NUMBER = 5;

const String MAIN_PAGE = 'main_page';
const String NEWS_PAGE = 'news_page';
const String NEWS_PAGE_SHIMMER = 'news_page_shimmer';
const String PROFILE_PAGE = 'profile_page';
const String PROFILE_PAGE_SHIMMER = 'profile_page_shimmer';
const String BIRTHDAY_PAGE = 'birthday_page';
const String BIRTHDAY_PAGE_SHIMMER = 'birthday_page_shimmer';
const String POLLS_PAGE= 'polls_page';
const String VIDEO_PAGE = 'video_page';

///Different
const String UPDATE_FOOTER = 'footer';
const String UPDATE_HEADER = 'header';

const String PAGE = 'page';

const double BOTTOM_NAVIGATION_BAR_HEIGHT = 50.0;

///Cache
const String CACHE_BIRTHDAY = 'cache_birthday';


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
