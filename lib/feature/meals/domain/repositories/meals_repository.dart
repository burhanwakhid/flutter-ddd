import 'package:dartz/dartz.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:flutter_meals/feature/meals/data/database/favorite_db.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';

abstract class MealsRepository {
  Future<Either<Failure, List<MealsEntity>>> getListMeals(String search);

  Future<Either<Failure, List<MealsEntity>>> getFavoriteListMeals();

  Future<Either<Failure, void>> deleteFavoriteListMeals(FavoriteTable id);

  Future<Either<Failure, void>> saveFavoriteListMeals(MealsEntity entity);
}
