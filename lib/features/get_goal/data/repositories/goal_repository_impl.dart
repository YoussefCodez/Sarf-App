import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/remote_goal_entity.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/config/utils/out_put_print_util.dart';
import 'package:finance_tracking/config/services/network_info_service.dart';
import 'package:finance_tracking/features/get_goal/data/data_source/remote_goal_data_source.dart';
import 'package:finance_tracking/features/get_goal/data/data_source/local_goal_data_source.dart';
import 'package:finance_tracking/features/get_goal/data/models/home_local_goal_model.dart';
import 'package:finance_tracking/features/get_goal/domain/repositories/goal_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GoalRepositoryContract)
class GoalRepositoryImpl implements GoalRepositoryContract {
  final RemoteGoalDataSource remoteGoalDataSource;
  final SupabaseErrorHandlerService supabaseErrorHandlerService;
  final LocalGoalDataSource localGoalDataSource;
  final NetworkInfo networkInfo;

  GoalRepositoryImpl({
    required this.remoteGoalDataSource,
    required this.supabaseErrorHandlerService,
    required this.localGoalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, RemoteGoalEntity>> getGoal() async {
    try {
      final isOnline = await networkInfo.isConnected;
      if (isOnline) {
        final goal = await remoteGoalDataSource.getGoal();
        if (goal == null) {
          return const Left("You haven't set a main goal yet.");
        }
        final localGoal = HomeLocalGoalModel.fromEntity(goal);
        await localGoalDataSource.saveGoal(localGoal);
        return Right(goal);
      } else {
        final cachedGoal = await localGoalDataSource.getGoal();
        if (cachedGoal != null) {
          return Right(cachedGoal.toEntity());
        }
        return const Left("Offline and no cached goal found");
      }
    } catch (e) {
      printOutPut(e);
      final cachedGoal = await localGoalDataSource.getGoal();
      if (cachedGoal != null) {
        return Right(cachedGoal.toEntity());
      }
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }
}
