import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:flutter_meals/core/usecases/usecase.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/feature/meals/domain/repositories/meals_repository.dart';

class GetFavoriteMeals implements UseCase<List<MealsEntity>, NoParams> {
  final MealsRepository repository;

  GetFavoriteMeals({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<MealsEntity>>> call(NoParams params) async {
    return await repository.getFavoriteListMeals();
  }
}
