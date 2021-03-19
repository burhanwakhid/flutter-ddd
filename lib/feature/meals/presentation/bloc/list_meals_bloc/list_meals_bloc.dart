import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/get_list_meals.dart'
    as usecase;
import 'package:meta/meta.dart';

part 'list_meals_event.dart';
part 'list_meals_state.dart';

class ListMealsBloc extends Bloc<ListMealsEvent, ListMealsState> {
  final usecase.GetListMeals getListMeals;

  ListMealsBloc({
    @required usecase.GetListMeals meals,
  })  : getListMeals = meals,
        super(Empty());

  @override
  Stream<ListMealsState> mapEventToState(
    ListMealsEvent event,
  ) async* {
    if (event is GetListMeals) {
      yield Loading();
      final failureOrMeals =
          await getListMeals(usecase.Params(search: event.search));
      yield* _eitherLoadedOrErrorState(failureOrMeals);
    }
  }

  Stream<ListMealsState> _eitherLoadedOrErrorState(
    Either<Failure, List<MealsEntity>> failureOrMeals,
  ) async* {
    yield failureOrMeals.fold(
      (failure) => Error(message: 'There Is something wrong'),
      (meals) => Loaded(meals: meals),
    );
  }
}
