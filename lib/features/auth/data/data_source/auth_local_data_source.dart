import 'package:finance_tracking/features/auth/data/models/local_user_profile_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveUserProfile(LocalUserProfileModel userProfile);
  LocalUserProfileModel? getUserProfile();
  Future<void> clearUserProfile();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'user_profile_box';
  static const String _userKey = 'current_user_profile';

  AuthLocalDataSourceImpl(this._hive);

  @override
  Future<void> saveUserProfile(LocalUserProfileModel userProfile) async {
    final box = await _hive.openBox(_boxName);
    await box.put(_userKey, userProfile);
  }

  @override
  LocalUserProfileModel? getUserProfile() {
    if (!_hive.isBoxOpen(_boxName)) return null;
    return _hive.box(_boxName).get(_userKey);
  }

  @override
  Future<void> clearUserProfile() async {
    final box = await _hive.openBox(_boxName);
    await box.delete(_userKey);
  }
}
