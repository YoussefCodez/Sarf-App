import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveModule {
  @lazySingleton
  HiveInterface get hive => Hive;
}
