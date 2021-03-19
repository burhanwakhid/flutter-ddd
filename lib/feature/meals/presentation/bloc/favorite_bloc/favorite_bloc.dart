import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:flutter_meals/core/usecases/usecase.dart';
import 'package:flutter_meals/feature/meals/data/database/favorite_db.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/delete_favorite_meals.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/get_favorite_meals.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final AppDatabase database;
  final GetFavoriteMeals _favoriteMeals;
  final DeleteFavorite _deleteFavorite;
  FavoriteBloc({
    @required AppDatabase db,
    @required GetFavoriteMeals favoriteMeals,
    @required DeleteFavorite deleteFavorite,
  })  : database = db,
        _deleteFavorite = deleteFavorite,
        _favoriteMeals = favoriteMeals,
        super(Empty());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is AddFavorite) {
      try {
        await database.insertNewOrder(FavoriteTable(
          id: int.parse(event.entity.idMeal),
          strMeal: event.entity.strMeal,
          strCategory: event.entity.strCategory,
          strArea: event.entity.strArea,
          strInstructions: event.entity.strInstructions,
          strMealThumb: event.entity.strMealThumb,
          strTags: event.entity.strTags,
          strYoutube: event.entity.strYoutube,
          strIngredient1: event.entity.strIngredient1,
          strIngredient2: event.entity.strIngredient2,
          strIngredient3: event.entity.strIngredient3,
          strIngredient4: event.entity.strIngredient4,
          strIngredient5: event.entity.strIngredient5,
          strIngredient6: event.entity.strIngredient6,
          strIngredient7: event.entity.strIngredient7,
          strIngredient8: event.entity.strIngredient8,
          strIngredient9: event.entity.strIngredient9,
          strIngredient10: event.entity.strIngredient10,
          strIngredient11: event.entity.strIngredient11,
          strIngredient12: event.entity.strIngredient12,
          strIngredient13: event.entity.strIngredient13,
          strIngredient14: event.entity.strIngredient14,
          strIngredient15: event.entity.strIngredient15,
          strIngredient16: event.entity.strIngredient16,
          strIngredient17: event.entity.strIngredient17,
          strIngredient18: event.entity.strIngredient18,
          strIngredient19: event.entity.strIngredient19,
          strIngredient20: event.entity.strIngredient20,
          strMeasure1: event.entity.strMeasure1,
          strMeasure2: event.entity.strMeasure2,
          strMeasure3: event.entity.strMeasure3,
          strMeasure4: event.entity.strMeasure4,
          strMeasure5: event.entity.strMeasure5,
          strMeasure6: event.entity.strMeasure6,
          strMeasure7: event.entity.strMeasure7,
          strMeasure8: event.entity.strMeasure8,
          strMeasure9: event.entity.strMeasure9,
          strMeasure10: event.entity.strMeasure10,
          strMeasure11: event.entity.strMeasure11,
          strMeasure12: event.entity.strMeasure12,
          strMeasure13: event.entity.strMeasure13,
          strMeasure14: event.entity.strMeasure14,
          strMeasure15: event.entity.strMeasure15,
          strMeasure16: event.entity.strMeasure16,
          strMeasure17: event.entity.strMeasure17,
          strMeasure18: event.entity.strMeasure18,
          strMeasure19: event.entity.strMeasure19,
          strMeasure20: event.entity.strMeasure20,
          strSource: event.entity.strSource,
        ));
        yield AddSuccess();
      } catch (e) {
        print('object');
        yield Error(message: 'database error');
      }
    } else if (event is GetFavorite) {
      yield Loading();
      final data = await _favoriteMeals(NoParams());

      yield* _eitherLoadedOrErrorState(data);
      // print(data);
    } else if (event is DeleteFavoriteEvent) {
      try {
        var data = await _deleteFavorite(Params(entity: event.entity));
        yield data.fold(
          (l) => Error(message: 'error'),
          (r) => DeleteSuccess(),
        );
      } catch (e) {
        yield Error(message: 'error');
      }
    }
  }

  Stream<FavoriteState> _eitherLoadedOrErrorState(
    Either<Failure, List<MealsEntity>> failureOrMeals,
  ) async* {
    yield failureOrMeals.fold(
      (failure) => Error(message: 'There Is something wrong'),
      (meals) => Loaded(meals: meals),
    );
  }
}
