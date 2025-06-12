import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/features/splash/domain/use_case/verify_user.dart';
import 'package:cos_challenge/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifyUserUseCase extends Mock implements VerifyUserUseCase {}

void main() {
  late SplashCubit splashCubit;
  late MockVerifyUserUseCase mockVerifyUserUseCase;
  final mockUser = const UserModel(name: 'Test User', email: 'test@example.com');

  setUp(() {
    mockVerifyUserUseCase = MockVerifyUserUseCase();
    splashCubit = SplashCubit(mockVerifyUserUseCase);
  });

  tearDown(() {
    splashCubit.close();
  });

  group('SplashCubit Test', () {
    test('initial state is SplashInitial', () {
      expect(splashCubit.state, equals(const SplashInitial()));
    });

    blocTest<SplashCubit, SplashState>(
      'emits [SplashInitial, SplashUserFound] when checkUser succeeds',
      build: () {
        when(() => mockVerifyUserUseCase.call()).thenAnswer((_) async => mockUser);
        return splashCubit;
      },
      act: (cubit) => cubit.checkUser(),
      expect: () => [
        const SplashInitial(),
        const SplashUserFound(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashInitial, SplashUserNotFound] when checkUser fails',
      build: () {
        when(() => mockVerifyUserUseCase.call()).thenThrow(Exception('User not found'));
        return splashCubit;
      },
      act: (cubit) => cubit.checkUser(),
      expect: () => [
        const SplashInitial(),
        const SplashUserNotFound(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'calls VerifyUserUseCase when checkUser is called',
      build: () {
        when(() => mockVerifyUserUseCase.call()).thenAnswer((_) async => mockUser);
        return splashCubit;
      },
      act: (cubit) => cubit.checkUser(),
      verify: (_) {
        verify(() => mockVerifyUserUseCase.call()).called(1);
      },
    );
  });
}
