import 'package:dio/dio.dart';
import 'package:flutter_meals/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:flutter_meals/feature/meals/data/models/list_meals_model.dart';

abstract class MealsRemoteDataSource {
  Future<ListMealModel> getListMeals(String search);
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final Dio dio;

  MealsRemoteDataSourceImpl({@required this.dio});

  String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  @override
  Future<ListMealModel> getListMeals(String search) {
    return _getListMealFromUrl('search.php?s=$search');
  }

  Future<ListMealModel> _getListMealFromUrl(String url) async {
    try {
      final response = await dio.get(_baseUrl + url);
      print(response.data);
      final res = ListMealModel.fromJson(response.data);
      return res;
    } on DioError catch (_) {
      throw ServerException();
      // if (e.response.statusCode == 401) {
      //   print(e.response.statusMessage);
      //   throw Exception(e.response.statusCode);
      // } else if (e.response.statusCode >= 400 && e.response.statusCode < 500) {
      //   print(e.message);
      //   ErrorModel errorModel = ErrorModel.fromJson(e.response.data);
      //   throw ErrorException(errorModel);
      // } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      //   throw TimeOutException();
      // } else {
      //   throw BadRequestException();
      // }
    }
  }
}
