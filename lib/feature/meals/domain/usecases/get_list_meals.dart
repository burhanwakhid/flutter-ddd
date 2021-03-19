import 'package:equatable/equatable.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_meals/core/usecases/usecase.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/feature/meals/domain/repositories/meals_repository.dart';
import 'package:meta/meta.dart';

class GetListMeals implements UseCase<List<MealsEntity>, Params> {
  final MealsRepository mealsRepository;

  GetListMeals(this.mealsRepository);

  @override
  Future<Either<Failure, List<MealsEntity>>> call(Params params) async {
    return await mealsRepository.getListMeals(params.search);
  }
}

class Params extends Equatable {
  final String search;

  Params({@required this.search});

  @override
  List<Object> get props => [search];
}
