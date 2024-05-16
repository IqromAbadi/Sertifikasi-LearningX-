part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SPLASHSCREEN = _Paths.SPLASHSCREEN;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SPLASHSCREEN = '/splashscreen';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const RESET_PASSWORD = '/reset-password';
}
