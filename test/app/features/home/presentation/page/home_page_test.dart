import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/user_info_cubit.dart';
import 'package:cos_challenge/app/features/home/presentation/page/home_page.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/car_loading_widget.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/no_car_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/car_model_fixture.dart';
import '../../../../../fixtures/user_model_fixture.dart';
import '../../../../../helpers/widget_test_helper.dart';


class MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}
class MockCarSearchCubit extends MockCubit<CarSearchState> implements CarSearchCubit {}

void main() {
  late MockUserInfoCubit mockUserInfoCubit;
  late MockCarSearchCubit mockCarSearchCubit;

  setUp(() {
    mockUserInfoCubit = MockUserInfoCubit();
    mockCarSearchCubit = MockCarSearchCubit();
  });

  Widget createWidgetUnderTest() {
    return WidgetTestHelper.wrapWithMaterialApp(
      HomePage(
        userCubit: mockUserInfoCubit,
        carCubit: mockCarSearchCubit,
      ),
    );
  }

  group('HomePage', () {
    testWidgets('should display welcome message when user info is loaded', (tester) async {
      // Arrange
      final user = UserModelFixture.validUser();
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoLoaded(user));
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Welcome back, ${user.name}'), findsOneWidget);
      expect(find.byIcon(Icons.logout_rounded), findsOneWidget);
    });

    testWidgets('should display generic welcome message when user info is not loaded', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Welcome back'), findsOneWidget);
    });

    testWidgets('should display search input field and button', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Digite o VIN do veículo (17 caracteres)'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('should show loading widget when car search is loading', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchLoading());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CarSearchLoadingWidget), findsOneWidget);
    });

    testWidgets('should show no car found widget when search returns empty', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(NoCarFoundWidget), findsOneWidget);
    });

    testWidgets('should show error message when car search fails', (tester) async {
      // Arrange
      const errorMessage = 'Failed to search car';
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(
        const CarSearchError(CarSearchFailure(errorMessage)),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should show multiple cars when multiple results are found', (tester) async {
      // Arrange
      final carInfoList = [
        CarModelFixture.validCarInfo(),
        CarModelFixture.validCarInfo().copyWith(
          make: 'Toyota',
          model: 'Camry',
          similarity: 95.5,
        ),
      ];
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(
        MultipleCarSearchLoaded(carInfoList),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('${carInfoList[0].make} ${carInfoList[0].model}'), findsOneWidget);
      expect(find.text('${carInfoList[1].make} ${carInfoList[1].model}'), findsOneWidget);
      expect(find.text('Similarity: ${carInfoList[0].similarity.toStringAsFixed(2)}%'), findsOneWidget);
      expect(find.text('Similarity: ${carInfoList[1].similarity.toStringAsFixed(2)}%'), findsOneWidget);
    });

    testWidgets('should clear search field when clear button is tapped', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.byType(TextField), 'TEST123');
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      // Assert
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should call searchCarByVin when search button is tapped with valid VIN', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());
      when(() => mockCarSearchCubit.searchCarByVin(any())).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.byType(TextField), '1HGBH41JXMN109186');
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Assert
      verify(() => mockCarSearchCubit.searchCarByVin('1HGBH41JXMN109186')).called(1);
    });

    testWidgets('should not call searchCarByVin when search button is tapped with invalid VIN', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.byType(TextField), 'INVALID');
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Assert
      verifyNever(() => mockCarSearchCubit.searchCarByVin(any()));
    });

    testWidgets('should call getUserInfo and loadCachedCars on initialization', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchInitial());
      when(() => mockUserInfoCubit.getUserInfo()).thenReturn(null);
      when(() => mockCarSearchCubit.loadCachedCars()).thenReturn(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      verify(() => mockUserInfoCubit.getUserInfo()).called(1);
      verify(() => mockCarSearchCubit.loadCachedCars()).called(1);
    });

    testWidgets('should disable search button when loading', (tester) async {
      // Arrange
      when(() => mockUserInfoCubit.state).thenReturn(UserInfoInitial());
      when(() => mockCarSearchCubit.state).thenReturn(CarSearchLoading());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final searchButton = tester.widget<ButtonStyleButton>(
        find.ancestor(
          of: find.text('Search'),
          matching: find.byType(ButtonStyleButton),
        ),
      );
      expect(searchButton.onPressed, isNull);
    });
  });
}
