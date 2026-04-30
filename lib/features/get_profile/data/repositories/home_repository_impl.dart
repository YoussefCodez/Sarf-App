import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/user_profile_entity.dart';
import 'package:finance_tracking/config/services/network_info_service.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/config/utils/out_put_print_util.dart';
import 'package:finance_tracking/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:finance_tracking/features/auth/data/models/local_user_profile_model.dart';
import 'package:finance_tracking/features/get_profile/data/data_soruce/remote_home_data_source.dart';
import 'package:finance_tracking/features/get_profile/domain/repositories/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepositoryContract)
class HomeRepositoryImpl implements HomeRepositoryContract {
  final RemoteHomeDataSource remoteHomeDataSource;
  final SupabaseErrorHandlerService supabaseErrorHandlerService;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl({
    required this.remoteHomeDataSource,
    required this.supabaseErrorHandlerService,
    required this.authLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<String, UserProfileEntity>> getProfile() async {
    try {
      final isOnline = await networkInfo.isConnected;
      if (isOnline) {
        final profile = await remoteHomeDataSource.getProfile();
        final localProfile = LocalUserProfileModel.fromEntity(profile);
        await authLocalDataSource.saveUserProfile(localProfile);
        return Right(profile.toEntity());
      } else {
        final cachedProfile = await authLocalDataSource.getUserProfile();
        if (cachedProfile != null) {
          return Right(cachedProfile.toEntity());
        }
        return const Left("Offline and no cached data found");
      }
    } catch (e) {
      printOutPut(e);
      final cachedProfile = await authLocalDataSource.getUserProfile();
      if (cachedProfile != null) {
        return Right(cachedProfile.toEntity());
      }
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }
}
