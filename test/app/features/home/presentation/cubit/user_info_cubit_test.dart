import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_user.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/logout_user.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

class MockLogoutUserUseCase extends Mock implements LogoutUserUseCase {}

void main() {
  late UserInfoCubit cubit;
  late MockGetUserUseCase mockGetUserUseCase;
  late MockLogoutUserUseCase mockLogoutUserUseCase;

  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    mockLogoutUserUseCase = MockLogoutUserUseCase();
    cubit = UserInfoCubit(mockGetUserUseCase, mockLogoutUserUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('UserInfoCubit Test', () {
    const mockUser = UserModel(
      email: 'test@example.com',
      name: 'Test User',
    );

    test('initial state is UserInfoInitial', () {
      expect(cubit.state, const UserInfoInitial());
    });

    group('getUserInfo', () {
      blocTest<UserInfoCubit, UserInfoState>(
        'emits UserInfoLoaded when getUserInfo succeeds',
        build: () {
          when(() => mockGetUserUseCase.call()).thenAnswer((_) async => mockUser);
          return cubit;
        },
        act: (cubit) => cubit.getUserInfo(),
        expect: () => [const UserInfoLoaded(mockUser)],
      );

      blocTest<UserInfoCubit, UserInfoState>(
        'emits UserInfoError when getUserInfo fails',
        build: () {
          when(() => mockGetUserUseCase.call()).thenThrow(Exception('Error'));
          return cubit;
        },
        act: (cubit) => cubit.getUserInfo(),
        expect: () => [const UserInfoError(UserNotFoundError())],
      );
    });

    group('logout', () {
      blocTest<UserInfoCubit, UserInfoState>(
        'emits UserLogout when logout succeeds',
        build: () {
          when(() => mockGetUserUseCase.call()).thenAnswer((_) async => mockUser);
          when(() => mockLogoutUserUseCase.call()).thenAnswer((_) async {});
          return cubit;
        },
        act: (cubit) => cubit.logout(),
        expect: () => [const UserLogout(mockUser)],
      );

      blocTest<UserInfoCubit, UserInfoState>(
        'emits UserInfoLoaded when logout fails',
        build: () {
          when(() => mockGetUserUseCase.call()).thenAnswer((_) async => mockUser);
          when(() => mockLogoutUserUseCase.call()).thenThrow(Exception('Logout failed'));
          return cubit;
        },
        act: (cubit) => cubit.logout(),
        expect: () => [const UserInfoLoaded(mockUser)],
      );
    });
  });
}
