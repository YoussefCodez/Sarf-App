import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/features/get_goal/data/data_source/remote_goal_data_source.dart';
import 'package:finance_tracking/features/get_goal/data/data_source/local_goal_data_source.dart';
import 'package:finance_tracking/features/get_goal/data/models/home_local_goal_model.dart';
import 'package:finance_tracking/features/get_goal/data/repositories/goal_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([
  RemoteGoalDataSource,
  LocalGoalDataSource,
  SupabaseErrorHandlerService,
])
import 'goal_repository_impl_test.mocks.dart';

void main() {
  late MockRemoteGoalDataSource remoteGoalDataSource;
  late MockLocalGoalDataSource localGoalDataSource;
  late MockSupabaseErrorHandlerService supabaseErrorHandlerService;
  late GoalRepositoryImpl goalRepositoryImpl;

  setUp(() {
    remoteGoalDataSource = MockRemoteGoalDataSource();
    localGoalDataSource = MockLocalGoalDataSource();
    supabaseErrorHandlerService = MockSupabaseErrorHandlerService();
    goalRepositoryImpl = GoalRepositoryImpl(
      remoteGoalDataSource: remoteGoalDataSource,
      localGoalDataSource: localGoalDataSource,
      supabaseErrorHandlerService: supabaseErrorHandlerService,
    );
  });

  final tDate = DateTime(2024, 1, 1);
  
  final tRemoteGoalModel = RemoteGoalModel(
    id: "id",
    userId: "user_123",
    createdAt: tDate,
    name: "Buy a car",
    image: "car_image_url",
    price: 50000.0,
  );

  test("should return goal and save it locally when remote call is successful", () async {
    final tLocalGoalModel = HomeLocalGoalModel.fromEntity(tRemoteGoalModel);

    // Arrange
    when(remoteGoalDataSource.getGoal())
        .thenAnswer((_) async => tRemoteGoalModel);
    when(localGoalDataSource.saveGoal(any))
        .thenAnswer((_) async => {});

    // Act
    final result = await goalRepositoryImpl.getGoal();

    // Assert
    expect(result, Right(tRemoteGoalModel));
    verify(remoteGoalDataSource.getGoal()).called(1);
    verify(localGoalDataSource.saveGoal(tLocalGoalModel)).called(1);
  });

  test("should return error when remote data source throws and NO cached data exists", () async {
    // Arrange
    final tException = Exception("Database error");
    when(remoteGoalDataSource.getGoal()).thenThrow(tException);
    when(localGoalDataSource.getGoal()).thenReturn(null);
    when(supabaseErrorHandlerService.handle(tException)).thenReturn("Server Error");

    // Act
    final result = await goalRepositoryImpl.getGoal();

    // Assert
    expect(result, const Left("Server Error"));
    verify(remoteGoalDataSource.getGoal()).called(1);
  });

  test("should return cached goal when remote call fails", () async {
    // Arrange
    final tLocalGoalModel = HomeLocalGoalModel.fromEntity(tRemoteGoalModel);
    when(remoteGoalDataSource.getGoal()).thenThrow(Exception());
    when(localGoalDataSource.getGoal()).thenReturn(tLocalGoalModel);

    // Act
    final result = await goalRepositoryImpl.getGoal();

    // Assert
    expect(result, Right(tLocalGoalModel.toEntity()));
    verify(localGoalDataSource.getGoal()).called(1);
  });
}
