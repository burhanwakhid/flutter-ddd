import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meals/core/error/exceptions.dart';
import 'package:flutter_meals/feature/meals/data/models/list_meals_model.dart';
import 'package:flutter_meals/feature/meals/data/sharedpreference/shared_local_storage_service.dart';

abstract class MealsLocalDataSource {
  Future<ListMealModel> getLastMeals();

  Future<void> cachedMeals(ListMealModel listMealModel);
}

const CACHED_LIST_MEALS = 'CACHED_LIST_MEALS';

class MealsLocalDataSourceImpl implements MealsLocalDataSource {
  final ILocalStorage sharedPreferences;

  MealsLocalDataSourceImpl({@required this.sharedPreferences});
  @override
  Future<void> cachedMeals(ListMealModel listMealModel) {
    return sharedPreferences.put(
        CACHED_LIST_MEALS, jsonEncode(listMealModel.toJson()));
  }

  @override
  Future<ListMealModel> getLastMeals() async {
    final jsonString = await sharedPreferences.getString(CACHED_LIST_MEALS);
    if (jsonString != null) {
      return Future.value(ListMealModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
