import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/user_model_fixture.dart';

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

void main() {
  group('UserInfoCubit', () {
    late MockGetUserUseCase mockGetUserUseCase;
    late UserInfoCubit userInfoCubit;

    setUp(() {
      mockGetUserUseCase = MockGetUserUseCase();
      userInfoCubit = UserInfoCubit(mockGetUserUseCase);
    });

    tearDown(() {
      userInfoCubit.close();
    });

    test('initial state is UserInfoInitial', () {
      expect(userInfoCubit.state, equals(const UserInfoInitial()));
    });

    group('getUserInfo', () {
      blocTest<UserInfoCubit, UserInfoState>(
        'emits [UserInfoLoaded] when getting user info is successful',
        build: () {
          when(() => mockGetUserUseCase.call())
              .thenAnswer((_) async => UserModelFixture.validUser());
          return userInfoCubit;
        },
        act: (cubit) => cubit.getUserInfo(),
        expect: () => [
          UserInfoLoaded(UserModelFixture.validUser()),
        ],
        verify: (_) {
          verify(() => mockGetUserUseCase.call()).called(1);
        },
      );

      blocTest<UserInfoCubit, UserInfoState>(
        'emits [UserInfoError] when getting user info fails',
        build: () {
          when(() => mockGetUserUseCase.call())
              .thenThrow(Exception('User not found'));
          return userInfoCubit;
        },
        act: (cubit) => cubit.getUserInfo(),
        expect: () => [
          isA<UserInfoError>()
              .having((state) => state.failure, 'failure', isA<UserNotFoundError>()),
        ],
        verify: (_) {
          verify(() => mockGetUserUseCase.call()).called(1);
        },
      );
    });

    group('logout', () {
      blocTest<UserInfoCubit, UserInfoState>(
        'emits [UserLogout] when logout is called',
        build: () => userInfoCubit,
        act: (cubit) => cubit.logout(),
        expect: () => [
          const UserLogout(),
        ],
      );
    });
  });
}
