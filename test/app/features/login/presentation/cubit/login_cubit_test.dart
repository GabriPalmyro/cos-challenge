import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveUserUseCase extends Mock implements SaveUserUseCase {}

void main() {
  group('LoginCubit', () {
    late MockSaveUserUseCase mockSaveUserUseCase;
    late LoginCubit loginCubit;

    setUp(() {
      mockSaveUserUseCase = MockSaveUserUseCase();
      loginCubit = LoginCubit(mockSaveUserUseCase);
    });

    tearDown(() {
      loginCubit.close();
    });

    test('initial state is LoginInitial', () {
      expect(loginCubit.state, equals(const LoginInitial()));
    });

    group('login', () {
      const testEmail = 'test@example.com';
      const testName = 'Test User';

      blocTest<LoginCubit, LoginState>(
        'emits [LoginLoading, LoginSuccess] when login is successful',
        build: () {
          when(() => mockSaveUserUseCase.call(any(), any()))
              .thenAnswer((_) async {});
          return loginCubit;
        },
        act: (cubit) => cubit.login(testEmail, testName),
        expect: () => [
          const LoginLoading(),
          const LoginSuccess(),
        ],
        verify: (_) {
          verify(() => mockSaveUserUseCase.call(testName, testEmail)).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginLoading, LoginFailure] when login fails',
        build: () {
          when(() => mockSaveUserUseCase.call(any(), any()))
              .thenThrow(Exception('Save user failed'));
          return loginCubit;
        },
        act: (cubit) => cubit.login(testEmail, testName),
        expect: () => [
          const LoginLoading(),
          isA<LoginFailure>()
              .having((state) => state.error, 'error', isA<InvalidCredentialsError>()),
        ],
        verify: (_) {
          verify(() => mockSaveUserUseCase.call(testName, testEmail)).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'calls saveUserUseCase with correct parameters',
        build: () {
          when(() => mockSaveUserUseCase.call(any(), any()))
              .thenAnswer((_) async {});
          return loginCubit;
        },
        act: (cubit) => cubit.login(testEmail, testName),
        verify: (_) {
          verify(() => mockSaveUserUseCase.call(testName, testEmail)).called(1);
        },
      );
    });
  });
}
