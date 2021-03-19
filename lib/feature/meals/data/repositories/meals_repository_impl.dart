import 'package:flutter_meals/core/helper/network/network_info.dart';
import 'package:flutter_meals/feature/meals/data/database/favorite_db.dart';
import 'package:flutter_meals/feature/meals/data/datasources/favorite_local_data_source.dart';
import 'package:flutter_meals/feature/meals/data/datasources/meals_remote_data_source.dart';
import 'package:flutter_meals/feature/meals/domain/entities/meals_entities.dart';
import 'package:flutter_meals/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_meals/feature/meals/domain/repositories/meals_repository.dart';

import 'package:meta/meta.dart';

// typedef Future<MealsEntity> _ConcreteOrRandomChooser();

class MealRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final FavoriteLocalDataSource favoriteLocalDataSource;

  MealRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
    @required this.favoriteLocalDataSource,
  });
  @override
  Future<Either<Failure, List<MealsEntity>>> getListMeals(String search) async {
    try {
      final remoteMeals = await remoteDataSource.getListMeals(search);
      return Right(remoteMeals.meals);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MealsEntity>>> getFavoriteListMeals() async {
    try {
      final data = await favoriteLocalDataSource.getListMeals();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavoriteListMeals(MealsEntity id) async {
    try {
      final response = await favoriteLocalDataSource.deleteMeals(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveFavoriteListMeals(
      MealsEntity entity) async {
    try {
      final response = await favoriteLocalDataSource.saveMeals(entity);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // Future<Either<Failure, MealsEntity>> _getMeals(
  //   _ConcreteOrRandomChooser getConcreteOrRandom,
  // ) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteMeals = await getConcreteOrRandom();
  //       localDataSource.cacheNumberTrivia(remoteMeals);
  //       return Right(remoteTrivia);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localTrivia = await localDataSource.getLastNumberTrivia();
  //       return Right(localTrivia);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
