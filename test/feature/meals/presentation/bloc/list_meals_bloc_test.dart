import 'package:dartz/dartz.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/get_list_meals.dart'
    as usecase;
import 'package:flutter_meals/feature/meals/presentation/bloc/list_meals_bloc/list_meals_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetListMeals extends Mock implements usecase.GetListMeals {}

main() {
  ListMealsBloc listMealsBloc;
  MockGetListMeals mockGetListMeals;

  setUp(() {
    mockGetListMeals = MockGetListMeals();
    listMealsBloc = ListMealsBloc(meals: mockGetListMeals);
  });

  test('initialState should be Empty', () {
    // assert
    expect(listMealsBloc.state, equals(Empty()));
  });

  group('Get List Meal', () {
    List<MealsEntity> data = [
      MealsEntity(
        idMeal: 'j',
        strMeal: 'strMeal',
        strCategory: 'strCategory',
        strArea: 'strArea',
        strInstructions: 'strInstructions',
        strMealThumb: 'strMealThumb',
        strTags: 'strTags',
        strYoutube: 'strYoutube',
        strIngredient1: 'strIngredient1',
        strIngredient2: 'strIngredient2',
        strIngredient3: 'strIngredient3',
        strIngredient4: 'strIngredient4',
        strIngredient5: 'strIngredient5',
        strIngredient6: 'strIngredient6',
        strIngredient7: 'strIngredient7',
        strIngredient8: 'strIngredient8',
        strIngredient9: 'strIngredient9',
        strIngredient10: 'strIngredient10',
        strIngredient11: 'strIngredient11',
        strIngredient12: 'strIngredient12',
        strIngredient13: 'strIngredient13',
        strIngredient14: 'strIngredient14',
        strIngredient15: 'strIngredient15',
        strIngredient16: 'strIngredient16',
        strIngredient17: 'strIngredient17',
        strIngredient18: 'strIngredient18',
        strIngredient19: 'strIngredient19',
        strIngredient20: 'strIngredient20',
        strMeasure1: 'strMeasure1',
        strMeasure2: 'strMeasure2',
        strMeasure3: 'strMeasure3',
        strMeasure4: 'strMeasure4',
        strMeasure5: 'strMeasure5',
        strMeasure6: 'strMeasure6',
        strMeasure7: 'strMeasure7',
        strMeasure8: 'strMeasure8',
        strMeasure9: 'strMeasure9',
        strMeasure10: 'strMeasure10',
        strMeasure11: 'strMeasure11',
        strMeasure12: 'strMeasure12',
        strMeasure13: 'strMeasure13',
        strMeasure14: 'strMeasure14',
        strMeasure15: 'strMeasure15',
        strMeasure16: 'strMeasure16',
        strMeasure17: 'strMeasure17',
        strMeasure18: 'strMeasure18',
        strMeasure19: 'strMeasure19',
        strMeasure20: 'strMeasure20',
        strSource: 'strSource',
      ),
    ];

    test('should get data from the getlistmeals use case', () async {
      when(mockGetListMeals(any)).thenAnswer((_) async => Right(data));
      // act
      listMealsBloc.add(GetListMeals());
      await untilCalled(mockGetListMeals(any));
      // assert
      verify(mockGetListMeals(usecase.Params(search: '')));
    });

    test('get list meals success', () async {
      when(mockGetListMeals(any)).thenAnswer((_) async => Right(data));

      final expected = [
        Empty(),
        Loading(),
        Loaded(meals: data),
      ];
      // act
      expectLater(listMealsBloc, emitsInOrder(expected));

      listMealsBloc.add(GetListMeals());
    });

    test('get list meals failed', () async {
      when(mockGetListMeals(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: 'There Is something wrong')
      ];
      // act
      expectLater(listMealsBloc, emitsInOrder(expected));

      listMealsBloc.add(GetListMeals());
    });
  });
}
