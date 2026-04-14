// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_ce_flutter.dart' as _i965;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/on_boarding/data/datasources/goal_local_datasource.dart'
    as _i428;
import '../../features/on_boarding/data/datasources/on_boarding_local_datasource.dart'
    as _i903;
import '../../features/on_boarding/data/repositories/goal_repository_impl.dart'
    as _i300;
import '../../features/on_boarding/data/repositories/on_boarding_repository_impl.dart'
    as _i644;
import '../../features/on_boarding/domain/repositories/goal_repository.dart'
    as _i155;
import '../../features/on_boarding/domain/repositories/on_boarding_repository.dart'
    as _i874;
import '../../features/on_boarding/domain/usecases/add_goal_usecase.dart'
    as _i394;
import '../../features/on_boarding/domain/usecases/save_end_on_boarding_usecase.dart'
    as _i102;
import '../../features/on_boarding/domain/usecases/save_tracking_reason_usecase.dart'
    as _i631;
import '../../features/on_boarding/domain/usecases/save_weekly_spending_usecase.dart'
    as _i1060;
import '../modules/hive_module.dart' as _i732;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    gh.lazySingleton<_i965.HiveInterface>(() => hiveModule.hive);
    gh.lazySingleton<_i903.OnBoardingLocalDataSource>(
      () => _i903.OnBoardingLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i428.GoalLocalDataSource>(
      () => _i428.GoalLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i874.OnBoardingRepository>(
      () =>
          _i644.OnBoardingRepositoryImpl(gh<_i903.OnBoardingLocalDataSource>()),
    );
    gh.lazySingleton<_i102.SaveEndOnBoardingUseCase>(
      () => _i102.SaveEndOnBoardingUseCase(gh<_i874.OnBoardingRepository>()),
    );
    gh.lazySingleton<_i631.SaveTrackingReasonUseCase>(
      () => _i631.SaveTrackingReasonUseCase(gh<_i874.OnBoardingRepository>()),
    );
    gh.lazySingleton<_i1060.SaveWeeklySpendingUseCase>(
      () => _i1060.SaveWeeklySpendingUseCase(gh<_i874.OnBoardingRepository>()),
    );
    gh.lazySingleton<_i155.GoalRepository>(
      () => _i300.GoalRepositoryImpl(gh<_i428.GoalLocalDataSource>()),
    );
    gh.lazySingleton<_i394.AddGoalUseCase>(
      () => _i394.AddGoalUseCase(gh<_i155.GoalRepository>()),
    );
    return this;
  }
}

class _$HiveModule extends _i732.HiveModule {}
