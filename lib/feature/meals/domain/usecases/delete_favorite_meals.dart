import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:flutter_meals/core/usecases/usecase.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/feature/meals/domain/repositories/meals_repository.dart';

class DeleteFavorite implements UseCase<void, Params> {
  final MealsRepository repository;

  DeleteFavorite({
    @required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteFavoriteListMeals(params.entity);
  }
}

class Params extends Equatable {
  final MealsEntity entity;

  Params({@required this.entity});

  @override
  List<Object> get props => [entity];
}
