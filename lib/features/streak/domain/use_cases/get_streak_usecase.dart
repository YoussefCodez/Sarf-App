import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:finance_tracking/features/streak/domain/repositories/streak_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetStreakUseCase {
  final StreakRepositoryContract repository;

  GetStreakUseCase({required this.repository});

  Future<Either<String, StreakEntity>> call() async {
    return repository.getStreak();
  }
}
