import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/user_profile_entity.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:finance_tracking/features/auth/data/models/local_user_profile_model.dart';
import 'package:finance_tracking/features/get_profile/data/data_soruce/remote_home_data_source.dart';
import 'package:finance_tracking/features/get_profile/data/repositories/home_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([
  RemoteHomeDataSource,
  AuthLocalDataSource,
  SupabaseErrorHandlerService,
])
import 'home_repository_impl_test.mocks.dart';

void main() {
  late HomeRepositoryImpl homeRepositoryImpl;
  late MockRemoteHomeDataSource mockRemoteHomeDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockSupabaseErrorHandlerService mockSupabaseErrorHandlerService;

  setUp(() {
    mockRemoteHomeDataSource = MockRemoteHomeDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockSupabaseErrorHandlerService = MockSupabaseErrorHandlerService();
    homeRepositoryImpl = HomeRepositoryImpl(
      remoteHomeDataSource: mockRemoteHomeDataSource,
      authLocalDataSource: mockAuthLocalDataSource,
      supabaseErrorHandlerService: mockSupabaseErrorHandlerService,
    );
  });

  final tDate = DateTime(2025, 2, 2);

  final tUserProfile = UserProfileEntity(
    id: '1',
    name: 'John Doe',
    email: 'youssef@gmail.com',
    createdAt: tDate,
    currentMoney: '1000',
    forGoal: true,
    weeklySpending: '1000',
  );

  final tRemoteUserProfile = RemoteUserProfileModel(
    id: '1',
    createdAt: tDate,
    currentMoney: '1000',
    forGoal: true,
    weeklySpending: '1000',
    email: 'youssef@gmail.com',
    name: 'John Doe',
  );

  test(
    'getProfile should return user profile and save it locally when remote call is successful',
    () async {
      // Arrange
      when(
        mockRemoteHomeDataSource.getProfile(),
      ).thenAnswer((_) async => tRemoteUserProfile);
      when(
        mockAuthLocalDataSource.saveUserProfile(any),
      ).thenAnswer((_) async => {});

      // Act
      final result = await homeRepositoryImpl.getProfile();
      final tUserProfile = tRemoteUserProfile.toEntity();

      // Assert
      expect(result, Right(tUserProfile));
      verify(mockRemoteHomeDataSource.getProfile()).called(1);
      verify(mockAuthLocalDataSource.saveUserProfile(any)).called(1);
    },
  );

  test(
    'getProfile should return cached profile when remote call fails',
    () async {
      // Arrange
      when(mockRemoteHomeDataSource.getProfile()).thenThrow(Exception());
      when(mockAuthLocalDataSource.getUserProfile()).thenReturn(
        LocalUserProfileModel(
          id: '1',
          name: 'John Doe',
          email: 'youssef@gmail.com',
          weeklySpending: '1000',
          forGoal: true,
          createdAt: tDate,
          currentMoney: '1000',
        ),
      );

      // Act
      final result = await homeRepositoryImpl.getProfile();

      // Assert
      expect(result, Right(tUserProfile));
      verify(mockAuthLocalDataSource.getUserProfile()).called(1);
    },
  );

  test(
    'getProfile should return error when remote and local calls both fail',
    () async {
      // Arrange
      final tException = Exception("Network Error");
      when(mockRemoteHomeDataSource.getProfile()).thenThrow(tException);
      when(mockAuthLocalDataSource.getUserProfile()).thenReturn(null);
      when(
        mockSupabaseErrorHandlerService.handle(tException),
      ).thenReturn("Error Message");

      // Act
      final result = await homeRepositoryImpl.getProfile();

      // Assert
      expect(result, const Left("Error Message"));
    },
  );
}
