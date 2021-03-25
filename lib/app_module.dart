import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_meals/core/helper/network/network_info.dart';
import 'package:flutter_meals/core/network/dio_client.dart';
import 'package:flutter_meals/feature/meals/data/database/favorite_db.dart';
import 'package:flutter_meals/feature/meals/data/datasources/favorite_local_data_source.dart';
import 'package:flutter_meals/feature/meals/data/datasources/meals_local_data_source.dart';
import 'package:flutter_meals/feature/meals/data/datasources/meals_remote_data_source.dart';
import 'package:flutter_meals/feature/meals/data/repositories/meals_repository_impl.dart';
import 'package:flutter_meals/feature/meals/data/sharedpreference/shared_local_storage_service.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/delete_favorite_meals.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/get_favorite_meals.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/get_list_meals.dart';
import 'package:flutter_meals/feature/meals/domain/usecases/save_favorite_meals.dart';
import 'package:flutter_meals/feature/meals/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_meals/feature/meals/presentation/bloc/list_meals_bloc/list_meals_bloc.dart'
    as bloc;
import 'package:flutter_meals/feature/meals/presentation/pages/detail_meals_page.dart';
import 'package:flutter_meals/feature/meals/presentation/pages/favorite/favorite_page.dart';
import 'package:flutter_meals/feature/meals/presentation/pages/meals_homepage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'feature/meals/domain/repositories/meals_repository.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //Bloc
    Bind.factory((i) => bloc.ListMealsBloc(meals: i.call())),
    Bind.factory(
      (i) => FavoriteBloc(
        db: i.call(),
        favoriteMeals: i.call(),
        deleteFavorite: i.call(),
        saveFavoriteMeals: i.call(),
      ),
    ),

    // Use Cases
    Bind.lazySingleton((i) => GetListMeals(i.call())),
    Bind.lazySingleton((i) => GetFavoriteMeals(repository: i.call())),
    Bind.lazySingleton((i) => DeleteFavorite(repository: i.call())),
    Bind.lazySingleton((i) => SaveFavoriteMeals(repository: i.call())),

    // Repository
    Bind.lazySingleton<MealsRepository>(
      (i) => MealRepositoryImpl(
        remoteDataSource: i.call(),
        networkInfo: i.call(),
        favoriteLocalDataSource: i.call(),
        mealsLocalDataSource: i.call(),
      ),
    ),

    // Data sources
    Bind.lazySingleton<MealsRemoteDataSource>(
      (i) => MealsRemoteDataSourceImpl(dio: i.call()),
    ),
    Bind.lazySingleton<FavoriteLocalDataSource>(
        (i) => FavoriteLocalDataSourceImpl(appDatabase: i.call())),
    Bind.lazySingleton<MealsLocalDataSource>(
        (i) => MealsLocalDataSourceImpl(sharedPreferences: i.call())),

    // Api Client
    Bind.lazySingleton<DioClient>((i) => DioClient(i.call())),

    //! Core
    Bind.lazySingleton<NetworkInfo>((i) => NetworkInfoImpl(i.call())),

    //! External
    Bind.lazySingleton<ILocalStorage>((i) => SharedLocalStorageService()),
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton((i) => DataConnectionChecker()),
    Bind.singleton((i) => AppDatabase()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => MealsHomePage()),
    ChildRoute(
      '/detailMeals',
      child: (_, args) => DetailMealsPage(
        mealsEntity: args.data,
      ),
    ),
    ChildRoute('/favoriteMeals', child: (_, __) => FavoritePage()),
  ];
}
