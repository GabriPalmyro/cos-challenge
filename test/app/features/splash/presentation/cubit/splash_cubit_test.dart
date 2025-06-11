import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart';
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/user_model_fixture.dart';

class MockVerifyUserUseCase extends Mock implements VerifyUserUseCase {}

void main() {
  group('SplashCubit', () {
    late MockVerifyUserUseCase mockVerifyUserUseCase;
    late SplashCubit splashCubit;

    setUp(() {
      mockVerifyUserUseCase = MockVerifyUserUseCase();
      splashCubit = SplashCubit(mockVerifyUserUseCase);
    });

    tearDown(() {
      splashCubit.close();
    });

    test('initial state is SplashInitial', () {
      expect(splashCubit.state, equals(const SplashInitial()));
    });

    group('checkUser', () {
      blocTest<SplashCubit, SplashState>(
        'emits [SplashInitial, SplashUserFound] when user exists',
        build: () {
          when(() => mockVerifyUserUseCase.call())
              .thenAnswer((_) async => UserModelFixture.validUser());
          return splashCubit;
        },
        act: (cubit) => cubit.checkUser(),
        expect: () => [
          const SplashInitial(),
          const SplashUserFound(),
        ],
        verify: (_) {
          verify(() => mockVerifyUserUseCase.call()).called(1);
        },
      );

      blocTest<SplashCubit, SplashState>(
        'emits [SplashInitial, SplashUserNotFound] when user does not exist',
        build: () {
          when(() => mockVerifyUserUseCase.call())
              .thenThrow(Exception('User not found'));
          return splashCubit;
        },
        act: (cubit) => cubit.checkUser(),
        expect: () => [
          const SplashInitial(),
          const SplashUserNotFound(),
        ],
        verify: (_) {
          verify(() => mockVerifyUserUseCase.call()).called(1);
        },
      );
    });
  });
}
