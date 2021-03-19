import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meals/feature/meals/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteBloc favoriteBloc;

  @override
  void initState() {
    favoriteBloc = Modular.get<FavoriteBloc>();
    favoriteBloc.add(GetFavorite());
    super.initState();
  }

  @override
  void dispose() {
    favoriteBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // create: (context) => favoriteBloc,
      value: favoriteBloc,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            print(state);
            if (state is Loaded) {
              print('hahah');
              if (state.meals.isEmpty) {
                return Text('anda belum memilih favorite');
              } else {
                return ListView.builder(
                  itemCount: state.meals.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(state.meals[i].strMeal),
                    );
                  },
                );
              }
            } else if (state is Error) {
              return Text('error');
            } else if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
