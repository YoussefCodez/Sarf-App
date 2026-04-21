import 'package:finance_tracking/config/const/app_tables.dart';
import 'package:finance_tracking/config/models/remote_goal_model.dart';
import 'package:finance_tracking/config/models/remote_user_profile_model.dart';
import 'package:finance_tracking/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:finance_tracking/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:finance_tracking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource, User])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  const tEmail = "youssef@gmail.com";
  const tPassword = "password123";

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();

    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group("Sign Up With Email And Password", () {
    final tUserProfile = RemoteUserProfileModel(
      id: "id",
      name: "youssef",
      email: tEmail,
      weeklySpending: "100",
      forGoal: false,
      createdAt: DateTime.now(),
    );

    test(
      "should return AuthUserEntity when everything is successful (NO GOAL)",
      () async {
        // 1. Arrange
        final mockUser = MockUser();
        final tAuthResponse = AuthResponse(user: mockUser, session: null);

        when(mockUser.id).thenReturn("user_123");
        when(mockUser.toJson()).thenReturn({'id': 'user_123', 'email': tEmail});

        when(
          mockLocalDataSource.saveUserProfile(any),
        ).thenAnswer((_) async => {});

        final expectedData = tUserProfile.copyWith(id: 'user_123').toSupabase();

        when(
          mockRemoteDataSource.signUp(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => tAuthResponse);

        when(
          mockRemoteDataSource.insertData(
            table: AppTables.profiles,
            data: expectedData,
          ),
        ).thenAnswer((_) async => {});

        // 2. Act
        final result = await repository.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
          userProfileModel: tUserProfile,
        );

        // 3. Assert
        expect(result.isRight(), true);

        verify(
          mockRemoteDataSource.signUp(email: tEmail, password: tPassword),
        ).called(1);
        verify(mockLocalDataSource.saveUserProfile(any)).called(1);
      },
    );

    test(
      "should return AuthUserEntity when everything is successful (WITH GOAL)",
      () async {
        // 1. Arrange
        final mockUser = MockUser();
        final tAuthResponse = AuthResponse(user: mockUser, session: null);

        when(mockUser.id).thenReturn("user_123");
        when(mockUser.toJson()).thenReturn({'id': 'user_123', 'email': tEmail});

        when(
          mockLocalDataSource.saveUserProfile(any),
        ).thenAnswer((_) async => {});

        final expectedData = tUserProfile.copyWith(id: 'user_123').toSupabase();

        when(
          mockRemoteDataSource.signUp(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => tAuthResponse);

        when(
          mockRemoteDataSource.insertData(
            table: AppTables.profiles,
            data: expectedData,
          ),
        ).thenAnswer((_) async => {});

        final tGoalModel = RemoteGoalModel(
          id: "goal_1",
          userId: "id",
          createdAt: DateTime.now(),
          name: "Buy a car",
          image: "car_image_url",
          price: 50000.0,
        );

        final expectedGoalData = tGoalModel
            .copyWith(userId: 'user_123')
            .toSupabase();

        when(
          mockRemoteDataSource.insertData(
            table: AppTables.goal,
            data: expectedGoalData,
          ),
        ).thenAnswer((_) async => {});

        // 2. Act
        final result = await repository.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
          userProfileModel: tUserProfile,
          goalModel: tGoalModel,
        );

        // 3. Assert
        expect(result.isRight(), true);

        verify(
          mockRemoteDataSource.signUp(email: tEmail, password: tPassword),
        ).called(1);

        verify(mockLocalDataSource.saveUserProfile(any)).called(1);

        verify(
          mockRemoteDataSource.insertData(
            table: AppTables.goal,
            data: expectedGoalData,
          ),
        ).called(1);
      },
    );

    test("should return error when insert data failed", () async {
      // 1. Arrange
      final mockUser = MockUser();
      final tAuthResponse = AuthResponse(user: mockUser, session: null);

      when(mockUser.id).thenReturn("user_123");
      when(mockUser.toJson()).thenReturn({'id': 'user_123', 'email': tEmail});

      when(
        mockLocalDataSource.saveUserProfile(any),
      ).thenAnswer((_) async => {});

      final expectedData = tUserProfile.copyWith(id: 'user_123').toSupabase();

      when(
        mockRemoteDataSource.signUp(email: tEmail, password: tPassword),
      ).thenAnswer((_) async => tAuthResponse);

      when(
        mockRemoteDataSource.insertData(
          table: AppTables.profiles,
          data: expectedData,
        ),
      ).thenThrow(Exception("Failed to insert data"));

      // 2. Act
      final result = await repository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        userProfileModel: tUserProfile,
      );

      // 3. Verfiy
      expect(result.isLeft(), true);
    });
  });

  group("Sign In With Email And Password", () {
    test(
      "should return AuthUserEntity when everything is successful",
      () async {
        // 1. Arrange
        final mockUser = MockUser();
        final tAuthResponse = AuthResponse(user: mockUser, session: null);
        final tUserProfile = RemoteUserProfileModel(
          id: "id",
          name: "youssef",
          email: tEmail,
          weeklySpending: "100",
          forGoal: false,
          createdAt: DateTime.now(),
        );
        when(mockUser.id).thenReturn("user_123");
        when(mockUser.toJson()).thenReturn({'id': 'user_123', 'email': tEmail});

        when(
          mockRemoteDataSource.signIn(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => tAuthResponse);

        when(
          mockRemoteDataSource.selectSingle(
            table: AppTables.profiles,
            column: "id",
            value: "user_123",
          ),
        ).thenAnswer((_) async => tUserProfile.toSupabase());

        when(
          mockLocalDataSource.saveUserProfile(any),
        ).thenAnswer((_) async => {});

        // 2. Act
        final result = await repository.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );

        // 3. Assert
        expect(result.isRight(), true);

        verify(
          mockRemoteDataSource.signIn(email: tEmail, password: tPassword),
        ).called(1);

        verify(mockLocalDataSource.saveUserProfile(any)).called(1);
      },
    );

    test("should return error when sign in failed", () async {
      // 1. Arrange
      when(
        mockRemoteDataSource.signIn(email: tEmail, password: tPassword),
      ).thenThrow(Exception("Failed to sign in"));

      // 2. Act
      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // 3. Assert
      expect(result.isLeft(), true);

      verify(
        mockRemoteDataSource.signIn(email: tEmail, password: tPassword),
      ).called(1);
    });
  });
}
