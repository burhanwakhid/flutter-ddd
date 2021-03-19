import 'package:flutter_meals/core/error/exceptions.dart';
import 'package:flutter_meals/feature/meals/data/database/favorite_db.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:meta/meta.dart';

abstract class FavoriteLocalDataSource {
  Future<void> saveMeals(MealsEntity entity);
  Future<List<MealsEntity>> getListMeals();
  Future<void> deleteMeals(FavoriteTable mealsId);
  Future<bool> checkIfMealsFavorite(int mealsId);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final AppDatabase appDatabase;

  FavoriteLocalDataSourceImpl({
    @required this.appDatabase,
  });
  @override
  Future<bool> checkIfMealsFavorite(int mealsId) async {
    try {
      var data = await appDatabase.checkIsFavorite(mealsId);
      if (data.length < 0) {
        return false;
      } else
        return true;
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> deleteMeals(FavoriteTable favoriteTable) async {
    try {
      await appDatabase.deleteOrder(favoriteTable);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<MealsEntity>> getListMeals() async {
    try {
      final data = await appDatabase.getAllOrder();
      List<MealsEntity> s = [];
      data.forEach((element) {
        s.add(MealsEntity(
          idMeal: element.id.toString(),
          strMeal: element.strMeal,
          strCategory: element.strCategory,
          strArea: element.strArea,
          strInstructions: element.strInstructions,
          strMealThumb: element.strMealThumb,
          strTags: element.strTags,
          strYoutube: element.strYoutube,
          strIngredient1: element.strIngredient1,
          strIngredient2: element.strIngredient2,
          strIngredient3: element.strIngredient3,
          strIngredient4: element.strIngredient4,
          strIngredient5: element.strIngredient5,
          strIngredient6: element.strIngredient6,
          strIngredient7: element.strIngredient7,
          strIngredient8: element.strIngredient8,
          strIngredient9: element.strIngredient9,
          strIngredient10: element.strIngredient10,
          strIngredient11: element.strIngredient11,
          strIngredient12: element.strIngredient12,
          strIngredient13: element.strIngredient13,
          strIngredient14: element.strIngredient14,
          strIngredient15: element.strIngredient15,
          strIngredient16: element.strIngredient16,
          strIngredient17: element.strIngredient17,
          strIngredient18: element.strIngredient18,
          strIngredient19: element.strIngredient19,
          strIngredient20: element.strIngredient20,
          strMeasure1: element.strMeasure1,
          strMeasure2: element.strMeasure2,
          strMeasure3: element.strMeasure3,
          strMeasure4: element.strMeasure4,
          strMeasure5: element.strMeasure5,
          strMeasure6: element.strMeasure6,
          strMeasure7: element.strMeasure7,
          strMeasure8: element.strMeasure8,
          strMeasure9: element.strMeasure9,
          strMeasure10: element.strMeasure10,
          strMeasure11: element.strMeasure11,
          strMeasure12: element.strMeasure12,
          strMeasure13: element.strMeasure13,
          strMeasure14: element.strMeasure14,
          strMeasure15: element.strMeasure15,
          strMeasure16: element.strMeasure16,
          strMeasure17: element.strMeasure17,
          strMeasure18: element.strMeasure18,
          strMeasure19: element.strMeasure19,
          strMeasure20: element.strMeasure20,
          strSource: element.strSource,
        ));
      });
      return s;
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> saveMeals(MealsEntity entity) async {
    try {
      await appDatabase.insertNewOrder(FavoriteTable(
        id: int.parse(entity.idMeal),
        strMeal: entity.strMeal,
        strCategory: entity.strCategory,
        strArea: entity.strArea,
        strInstructions: entity.strInstructions,
        strMealThumb: entity.strMealThumb,
        strTags: entity.strTags,
        strYoutube: entity.strYoutube,
        strIngredient1: entity.strIngredient1,
        strIngredient2: entity.strIngredient2,
        strIngredient3: entity.strIngredient3,
        strIngredient4: entity.strIngredient4,
        strIngredient5: entity.strIngredient5,
        strIngredient6: entity.strIngredient6,
        strIngredient7: entity.strIngredient7,
        strIngredient8: entity.strIngredient8,
        strIngredient9: entity.strIngredient9,
        strIngredient10: entity.strIngredient10,
        strIngredient11: entity.strIngredient11,
        strIngredient12: entity.strIngredient12,
        strIngredient13: entity.strIngredient13,
        strIngredient14: entity.strIngredient14,
        strIngredient15: entity.strIngredient15,
        strIngredient16: entity.strIngredient16,
        strIngredient17: entity.strIngredient17,
        strIngredient18: entity.strIngredient18,
        strIngredient19: entity.strIngredient19,
        strIngredient20: entity.strIngredient20,
        strMeasure1: entity.strMeasure1,
        strMeasure2: entity.strMeasure2,
        strMeasure3: entity.strMeasure3,
        strMeasure4: entity.strMeasure4,
        strMeasure5: entity.strMeasure5,
        strMeasure6: entity.strMeasure6,
        strMeasure7: entity.strMeasure7,
        strMeasure8: entity.strMeasure8,
        strMeasure9: entity.strMeasure9,
        strMeasure10: entity.strMeasure10,
        strMeasure11: entity.strMeasure11,
        strMeasure12: entity.strMeasure12,
        strMeasure13: entity.strMeasure13,
        strMeasure14: entity.strMeasure14,
        strMeasure15: entity.strMeasure15,
        strMeasure16: entity.strMeasure16,
        strMeasure17: entity.strMeasure17,
        strMeasure18: entity.strMeasure18,
        strMeasure19: entity.strMeasure19,
        strMeasure20: entity.strMeasure20,
        strSource: entity.strSource,
      ));
    } catch (e) {
      throw DatabaseException();
    }
  }
}
