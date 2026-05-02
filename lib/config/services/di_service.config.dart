// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_ce_flutter.dart' as _i965;
import 'package:injectable/injectable.dart' as _i526;
import 'package:local_auth/local_auth.dart' as _i152;
import 'package:quick_actions/quick_actions.dart' as _i578;
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
import '../../features/daily_advice/domain/rules/advice_rule.dart' as _i568;
import '../../features/daily_advice/domain/usecases/get_daily_advice_usecase.dart'
    as _i392;
import '../../features/get_goal/data/data_source/local_goal_data_source.dart'
    as _i1004;
import '../../features/get_goal/data/data_source/remote_goal_data_source.dart'
    as _i598;
import '../../features/get_goal/data/repositories/goal_repository_impl.dart'
    as _i951;
import '../../features/get_goal/domain/repositories/goal_repository_contract.dart'
    as _i456;
import '../../features/get_goal/domain/use_cases/get_goal_use_case.dart'
    as _i861;
import '../../features/get_profile/data/data_soruce/remote_home_data_source.dart'
    as _i190;
import '../../features/get_profile/data/repositories/home_repository_impl.dart'
    as _i412;
import '../../features/get_profile/domain/repositories/home_repository_contract.dart'
    as _i718;
import '../../features/get_profile/domain/use_cases/get_profile_use_case.dart'
    as _i519;
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
import '../../features/security_and_biometrics/data/data_sources/biometrics_local_data_source.dart'
    as _i886;
import '../../features/security_and_biometrics/data/data_sources/biometrics_platform_data_source.dart'
    as _i400;
import '../../features/security_and_biometrics/data/repositories/biometrics_repository_impl.dart'
    as _i669;
import '../../features/security_and_biometrics/domain/repositories/biometrics_repository_contract.dart'
    as _i216;
import '../../features/security_and_biometrics/domain/usecases/authenticate_usecase.dart'
    as _i578;
import '../../features/security_and_biometrics/domain/usecases/check_biometrics_support_usecase.dart'
    as _i665;
import '../../features/security_and_biometrics/domain/usecases/get_biometrics_status_usecase.dart'
    as _i88;
import '../../features/security_and_biometrics/domain/usecases/set_biometrics_enabled_usecase.dart'
    as _i87;
import '../../features/transaction/data/data_source/transaction_local_data_source.dart'
    as _i215;
import '../../features/transaction/data/data_source/transaction_remote_data_source.dart'
    as _i88;
import '../../features/transaction/data/repositories/transaction_repository_impl.dart'
    as _i600;
import '../../features/transaction/domain/repositories/transaction_repository_contract.dart'
    as _i266;
import '../../features/transaction/domain/use_cases/add_transaction_usecase.dart'
    as _i5;
import '../../features/transaction/domain/use_cases/get_transaction_usecase.dart'
    as _i934;
import '../../features/transaction/domain/use_cases/sync_transactions_usecase.dart'
    as _i91;
import '../modules/app_module.dart' as _i781;
import '../modules/hive_module.dart' as _i732;
import '../modules/supabase_module.dart' as _i742;
import 'network_info_service.dart' as _i236;
import 'supabase_error_handler_service.dart' as _i38;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final hiveModule = _$HiveModule();
    final supabaseModule = _$SupabaseModule();
    gh.lazySingleton<_i895.Connectivity>(() => appModule.connectivity);
    gh.lazySingleton<_i578.QuickActions>(() => appModule.quickActions);
    gh.lazySingleton<_i152.LocalAuthentication>(
      () => appModule.localAuthentication,
    );
    gh.lazySingleton<_i965.HiveInterface>(() => hiveModule.hive);
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient);
    gh.lazySingleton<_i38.SupabaseErrorHandlerService>(
      () => _i38.SupabaseErrorHandlerService(),
    );
    gh.lazySingleton<_i886.BiometricsLocalDataSource>(
      () => _i886.BiometricsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i400.BiometricsPlatformDataSource>(
      () => _i400.BiometricsPlatformDataSourceImpl(
        auth: gh<_i152.LocalAuthentication>(),
      ),
    );
    gh.lazySingleton<_i216.BiometricsRepositoryContract>(
      () => _i669.BiometricsRepositoryImpl(
        localDataSource: gh<_i886.BiometricsLocalDataSource>(),
        platformDataSource: gh<_i400.BiometricsPlatformDataSource>(),
      ),
    );
    gh.lazySingleton<_i182.AuthRemoteDataSource>(
      () => _i182.AuthRemoteDataSource(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i598.RemoteGoalDataSource>(
      () => _i598.RemoteGoalDataSource(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i190.RemoteHomeDataSource>(
      () => _i190.RemoteHomeDataSource(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i88.TransactionRemoteDataSource>(
      () => _i88.TransactionRemoteDataSource(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i578.AuthenticateUseCase>(
      () => _i578.AuthenticateUseCase(
        repository: gh<_i216.BiometricsRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i665.CheckBiometricsSupportUseCase>(
      () => _i665.CheckBiometricsSupportUseCase(
        repository: gh<_i216.BiometricsRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i88.GetBiometricsStatusUseCase>(
      () => _i88.GetBiometricsStatusUseCase(
        repository: gh<_i216.BiometricsRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i87.SetBiometricsEnabledUseCase>(
      () => _i87.SetBiometricsEnabledUseCase(
        repository: gh<_i216.BiometricsRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i903.OnBoardingLocalDataSource>(
      () => _i903.OnBoardingLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i236.NetworkInfo>(
      () => _i236.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i280.AuthLocalDataSource>(
      () => _i280.AuthLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i1004.LocalGoalDataSource>(
      () => _i1004.LocalGoalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i428.GoalLocalDataSource>(
      () => _i428.GoalLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.lazySingleton<_i215.TransactionLocalDataSource>(
      () => _i215.TransactionLocalDataSourceImpl(gh<_i965.HiveInterface>()),
    );
    gh.factoryParam<
      _i392.GetDailyAdviceUseCase,
      List<_i568.AdviceRule>,
      dynamic
    >((rules, _) => _i392.GetDailyAdviceUseCase(rules));
    gh.lazySingleton<_i155.GoalRepository>(
      () => _i300.GoalRepositoryImpl(
        gh<_i428.GoalLocalDataSource>(),
        gh<_i903.OnBoardingLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i456.GoalRepositoryContract>(
      () => _i951.GoalRepositoryImpl(
        remoteGoalDataSource: gh<_i598.RemoteGoalDataSource>(),
        supabaseErrorHandlerService: gh<_i38.SupabaseErrorHandlerService>(),
        localGoalDataSource: gh<_i1004.LocalGoalDataSource>(),
        networkInfo: gh<_i236.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i394.AddGoalUseCase>(
      () => _i394.AddGoalUseCase(gh<_i155.GoalRepository>()),
    );
    gh.lazySingleton<_i273.AuthRepositoryContract>(
      () => _i153.AuthRepositoryImpl(
        remoteDataSource: gh<_i182.AuthRemoteDataSource>(),
        localDataSource: gh<_i280.AuthLocalDataSource>(),
        supabaseErrorHandlerService: gh<_i38.SupabaseErrorHandlerService>(),
      ),
    );
    gh.lazySingleton<_i718.HomeRepositoryContract>(
      () => _i412.HomeRepositoryImpl(
        remoteHomeDataSource: gh<_i190.RemoteHomeDataSource>(),
        supabaseErrorHandlerService: gh<_i38.SupabaseErrorHandlerService>(),
        authLocalDataSource: gh<_i280.AuthLocalDataSource>(),
        networkInfo: gh<_i236.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i874.OnBoardingRepository>(
      () =>
          _i644.OnBoardingRepositoryImpl(gh<_i903.OnBoardingLocalDataSource>()),
    );
    gh.lazySingleton<_i844.LogoutUsecase>(
      () => _i844.LogoutUsecase(repository: gh<_i273.AuthRepositoryContract>()),
    );
    gh.lazySingleton<_i861.GetGoalUseCase>(
      () => _i861.GetGoalUseCase(
        goalRepositoryContract: gh<_i456.GoalRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i266.TransactionRepositoryContract>(
      () => _i600.TransactionRepositoryImpl(
        remoteDataSource: gh<_i88.TransactionRemoteDataSource>(),
        localDataSource: gh<_i215.TransactionLocalDataSource>(),
        authLocalDataSource: gh<_i280.AuthLocalDataSource>(),
        supabaseErrorHandlerService: gh<_i38.SupabaseErrorHandlerService>(),
        networkInfo: gh<_i236.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i5.AddTransactionUseCase>(
      () => _i5.AddTransactionUseCase(
        repository: gh<_i266.TransactionRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i934.GetTransactionUseCase>(
      () => _i934.GetTransactionUseCase(
        repository: gh<_i266.TransactionRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i91.SyncTransactionsUseCase>(
      () => _i91.SyncTransactionsUseCase(
        repository: gh<_i266.TransactionRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i519.GetProfileUseCase>(
      () => _i519.GetProfileUseCase(
        homeRepositoryContract: gh<_i718.HomeRepositoryContract>(),
      ),
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
    return this;
  }
}

class _$AppModule extends _i781.AppModule {}

class _$HiveModule extends _i732.HiveModule {}

class _$SupabaseModule extends _i742.SupabaseModule {}
