import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:quick_actions/quick_actions.dart';

@module
abstract class AppModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  QuickActions get quickActions => QuickActions();

  @lazySingleton
  LocalAuthentication get localAuthentication => LocalAuthentication();
}
