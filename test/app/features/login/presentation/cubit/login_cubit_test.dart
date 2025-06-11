import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/core/errors/users_errors.dart';
import 'package:cos_challenge/app/features/login/domain/use_case/save_user.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveUserUseCase extends Mock implements SaveUserUseCase {}

void main() {
  group('LoginCubit Test |', () {
    late LoginCubit loginCubit;
    late MockSaveUserUseCase mockSaveUserUseCase;

    setUp(() {
      mockSaveUserUseCase = MockSaveUserUseCase();
      loginCubit = LoginCubit(mockSaveUserUseCase);
    });

    tearDown(() {
      loginCubit.close();
    });

    test('initial state is LoginInitial', () {
      expect(loginCubit.state, const LoginInitial());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () {
        when(() => mockSaveUserUseCase.call(any(), any())).thenAnswer((_) async {});
        return loginCubit;
      },
      act: (cubit) => cubit.login('test@email.com', 'Test User'),
      expect: () => [
        const LoginLoading(),
        const LoginSuccess(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails',
      build: () {
        when(() => mockSaveUserUseCase.call(any(), any())).thenThrow(Exception('Error'));
        return loginCubit;
      },
      act: (cubit) => cubit.login('test@email.com', 'Test User'),
      expect: () => [
        const LoginLoading(),
        const LoginFailure(InvalidCredentialsError()),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'calls SaveUserUseCase with correct parameters',
      build: () {
        when(() => mockSaveUserUseCase.call(any(), any())).thenAnswer((_) async {});
        return loginCubit;
      },
      act: (cubit) => cubit.login('test@email.com', 'Test User'),
      verify: (_) {
        verify(() => mockSaveUserUseCase.call('Test User', 'test@email.com')).called(1);
      },
    );
  });
}
