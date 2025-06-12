import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/design/tokens/cos_images.dart';
import 'package:cos_challenge/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:cos_challenge/app/features/login/presentation/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends Mock implements LoginCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoginPage Test', () {
    late MockLoginCubit mockCubit;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockCubit = MockLoginCubit();
      mockNavigatorObserver = MockNavigatorObserver();
      when(() => mockCubit.state).thenReturn(const LoginInitial());
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
      when(() => mockCubit.login(any(), any())).thenAnswer((_) async {});
    });

    Widget createWidget() {
      return MaterialApp(
        navigatorObservers: [mockNavigatorObserver],
        home: LoginPage(cubit: mockCubit),
      );
    }

    testWidgets('renders login page correctly', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(CosButton), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('displays logo image', (tester) async {
      await tester.pumpWidget(createWidget());

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName, CosImages.logo);
      expect(image.height, 120);
    });
    testWidgets('validates email field correctly', (tester) async {
      await tester.pumpWidget(createWidget());

      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'invalid-email');
      await tester.enterText(find.byType(TextFormField).last, 'John Doe');
      await tester.tap(find.byType(CosButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('calls login with correct data when form is valid', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'John Doe');
      await tester.tap(find.byType(CosButton));
      await tester.pumpAndSettle();

      verify(() => mockCubit.login('test@example.com', 'John Doe')).called(1);
    });

    testWidgets('shows loading state when login is loading', (tester) async {
      when(() => mockCubit.state).thenReturn(const LoginLoading());

      await tester.pumpWidget(createWidget());

      final button = tester.widget<CosButton>(find.byType(CosButton));
      expect(button.isLoading, isTrue);
    });

    testWidgets('submits form when name field is submitted', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'John Doe');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      verify(() => mockCubit.login('test@example.com', 'John Doe')).called(1);
    });
  });
}
