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
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/data_source/auth_local_data_source.dart'
    as _i280;
import '../../features/auth/data/data_source/auth_remote_data_source.dart'
    as _i182;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository_contract.dart'
    as _i273;
import '../../features/auth/domain/use_cases/login_usecase.dart' as _i1012;
import '../../features/auth/domain/use_cases/logout_usecase.dart' as _i844;
import '../../features/auth/domain/use_cases/signup_usecase.dart' as _i322;
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
import '../modules/supabase_module.dart' as _i742;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    final supabaseModule = _$SupabaseModule();
    gh.lazySingleton<_i965.HiveInterface>(() => hiveModule.hive);
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient);
    gh.lazySingleton<_i182.AuthRemoteDataSource>(
      () => _i182.AuthRemoteDataSource(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i903.OnBoardingLocalDataSource>(
      () => _i903.OnBoardingLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i280.AuthLocalDataSource>(
      () => _i280.AuthLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i273.AuthRepositoryContract>(
      () => _i153.AuthRepositoryImpl(
        remoteDataSource: gh<_i182.AuthRemoteDataSource>(),
        localDataSource: gh<_i280.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i428.GoalLocalDataSource>(
      () => _i428.GoalLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i874.OnBoardingRepository>(
      () =>
          _i644.OnBoardingRepositoryImpl(gh<_i903.OnBoardingLocalDataSource>()),
    );
    gh.lazySingleton<_i844.LogoutUsecase>(
      () => _i844.LogoutUsecase(repository: gh<_i273.AuthRepositoryContract>()),
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
    gh.lazySingleton<_i1012.LoginUsecase>(
      () => _i1012.LoginUsecase(
        authRepositoryContract: gh<_i273.AuthRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i322.SignupUsecase>(
      () => _i322.SignupUsecase(
        authRepositoryContract: gh<_i273.AuthRepositoryContract>(),
      ),
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

class _$SupabaseModule extends _i742.SupabaseModule {}
