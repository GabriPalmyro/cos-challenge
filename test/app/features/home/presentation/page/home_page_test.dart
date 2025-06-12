import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/router/router.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/design/design.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/page/home_page.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/car_loading_widget.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/no_car_found_widget.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/similar_cars_by_vin_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class MockCarSearchCubit extends MockCubit<CarSearchState> implements CarSearchCubit {}

class MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('HomePage Widget Tests', () {
    late MockCarSearchCubit mockCarSearchCubit;
    late MockUserInfoCubit mockUserInfoCubit;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockCarSearchCubit = MockCarSearchCubit();
      mockUserInfoCubit = MockUserInfoCubit();
      mockNavigatorObserver = MockNavigatorObserver();

      // Register mocks in GetIt
      if (GetIt.I.isRegistered<CarSearchCubit>()) {
        GetIt.I.unregister<CarSearchCubit>();
      }
      if (GetIt.I.isRegistered<UserInfoCubit>()) {
        GetIt.I.unregister<UserInfoCubit>();
      }
      GetIt.I.registerFactory<CarSearchCubit>(() => mockCarSearchCubit);
      GetIt.I.registerFactory<UserInfoCubit>(() => mockUserInfoCubit);
    });

    tearDown(() {
      GetIt.I.reset();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: const HomePage(),
        navigatorObservers: [mockNavigatorObserver],
        routes: {
          Routes.login: (context) => const Scaffold(body: Text('Login Page')),
          Routes.carInfo: (context) => const Scaffold(body: Text('Car Info Page')),
        },
      );
    }

    testWidgets('should display loading state initially', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchLoading());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CarSearchLoadingWidget), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display welcome message with user name when user info is loaded', (WidgetTester tester) async {
      // Arrange
      const testUser = UserModel(name: 'John Doe', email: 'john@test.com');
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoLoaded(testUser));
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Welcome back, John Doe'), findsOneWidget);
      expect(find.text('Here are your last searches'), findsOneWidget);
    });

    testWidgets('should display default welcome message when user info is not loaded', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Here are your last searches'), findsOneWidget);
    });

    testWidgets('should display search input and button', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('VIN Code (17 characters)'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('should display logout button', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.logout_rounded), findsOneWidget);
    });

    testWidgets('should clear text field when clear button is tapped', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter text
      await tester.enterText(find.byType(TextField), 'TEST1234567890123');
      await tester.pump();

      // Tap clear button
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // Assert
      expect(find.text('TEST1234567890123'), findsNothing);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should enforce VIN input constraints', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Try to enter invalid characters (I, O, Q)
      await tester.enterText(find.byType(TextField), 'IOQTEST1234567890123456789');
      await tester.pump();

      // Assert
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text.length, lessThanOrEqualTo(17));
      expect(textField.controller?.text.contains('I'), false);
      expect(textField.controller?.text.contains('O'), false);
      expect(textField.controller?.text.contains('Q'), false);
    });

    testWidgets('should display no cars found widget when car list is empty', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(NoCarFoundWidget), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
      expect(find.text('No search results found'), findsOneWidget);
    });

    testWidgets('should display cached car results', (WidgetTester tester) async {
      // Arrange
      final testCars = [
        CarInfoModel.fromJson(jsonDecode(carInfoResponse)),
      ];
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial(lastSearchResults: testCars));
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Toyota GT 86 Basis'), findsOneWidget);
      expect(find.text('Price: 150,00 €'), findsOneWidget);
      expect(find.text('ID: 123123'), findsOneWidget);
    });

    testWidgets('should trigger search when search button is tapped with valid VIN', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});
      when(() => mockCarSearchCubit.searchCarByVin(any())).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), '1HGCM82633A004352');
      await tester.pump();

      await tester.tap(find.text('Search'));
      await tester.pump();

      // Assert
      verify(() => mockCarSearchCubit.searchCarByVin('1HGCM82633A004352')).called(1);
    });

    testWidgets('should show snackbar with error when invalid VIN is entered', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), 'INVALID');
      await tester.pump();

      await tester.tap(find.text('Search'));
      await tester.pump();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
      verifyNever(() => mockCarSearchCubit.searchCarByVin(any()));
    });

    testWidgets('should trigger search when enter is pressed with valid VIN', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});
      when(() => mockCarSearchCubit.searchCarByVin(any())).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), '1HGCM82633A004352');
      await tester.pump();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Assert
      verify(() => mockCarSearchCubit.searchCarByVin('1HGCM82633A004352')).called(1);
    });

    testWidgets('should display button as disabled when search is loading', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchLoading());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final cosButton = tester.widget<CosButton>(find.byType(CosButton));
      expect(cosButton.onPressed, isNull);
      expect(cosButton.type, CosButtonType.ghost);
    });

    testWidgets('should call logout when logout button is tapped', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.logout()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.logout_rounded));
      await tester.pump();

      // Assert
      verify(() => mockUserInfoCubit.logout()).called(1);
    });

    testWidgets('should show similar cars modal when multiple cars are found', (WidgetTester tester) async {
      // Arrange
      final testCars = [
        CarModel.fromJson(jsonDecode(multipleOptionResponse)[0]),
        CarModel.fromJson(jsonDecode(multipleOptionResponse)[1]),
      ];

      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate multiple car search result
      when(() => mockCarSearchCubit.state).thenReturn(MultipleCarSearchLoaded(testCars, const []));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SimilarCarsByVinModal), findsOneWidget);
    });

    testWidgets('should show error snackbar when search fails', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate error state
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchError(CarsNotFoundError()));
      await tester.pump();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should show maintenance error snackbar when maintenance delay occurs', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate maintenance error
      const maintenanceError = CarMaintenanceDelayException(delayInSeconds: 30);
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchError(maintenanceError));
      await tester.pump();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should navigate to car info page when car is found', (WidgetTester tester) async {
      // Arrange
      final testCar = CarInfoModel.fromJson(jsonDecode(carInfoResponse));
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate successful car search
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchLoaded(testCar));
      await tester.pump();

      // Assert
      expect(find.text('Car Info Page'), findsOneWidget);
    });

    testWidgets('should navigate to car info when cached car is tapped', (WidgetTester tester) async {
      // Arrange
      final testCars = [
        CarInfoModel.fromJson(jsonDecode(carInfoResponse)),
      ];
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial(lastSearchResults: testCars));
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Car Info Page'), findsOneWidget);
    });

    testWidgets('should navigate to login page when user logs out', (WidgetTester tester) async {
      // Arrange
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate logout
      when(() => mockUserInfoCubit.state).thenReturn(
        const UserLogout(
          UserModel(
            name: 'John Doe',
            email: 'john@test.com',
          ),
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('should reload cached cars after successful search', (WidgetTester tester) async {
      // Arrange
      final testCar = CarInfoModel.fromJson(jsonDecode(carInfoResponse));
      when(() => mockCarSearchCubit.state).thenReturn(const CarSearchInitial());
      when(() => mockUserInfoCubit.state).thenReturn(const UserInfoInitial());
      when(() => mockCarSearchCubit.loadCachedCars()).thenAnswer((_) async {});
      when(() => mockUserInfoCubit.getUserInfo()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate successful car search
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchLoaded(testCar));
      await tester.pump();

      // Assert
      verify(() => mockCarSearchCubit.loadCachedCars()).called(greaterThanOrEqualTo(1));
    });
  });
}
