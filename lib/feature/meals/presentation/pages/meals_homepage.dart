import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_meals/feature/meals/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter_meals/feature/meals/presentation/bloc/list_meals_bloc/list_meals_bloc.dart';
import 'package:flutter_meals/feature/meals/presentation/widgets/list_meal_widget.dart';
import 'package:flutter_meals/shared/colors.dart';
import 'package:flutter_meals/shared/text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsHomePage extends StatefulWidget {
  @override
  _MealsHomePageState createState() => _MealsHomePageState();
}

class _MealsHomePageState extends State<MealsHomePage> {
  ListMealsBloc mealsBloc;
  // FavoriteBloc favoriteBloc;

  @override
  void initState() {
    mealsBloc = Modular.get<ListMealsBloc>();
    // favoriteBloc = Modular.get<FavoriteBloc>();
    mealsBloc.add(GetListMeals());
    super.initState();
  }

  @override
  void dispose() {
    mealsBloc?.close();
    // favoriteBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => mealsBloc,
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                backgroundColor0,
                backgroundColor2,
                backgroundColor1,
                backgroundColor1,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Good Morning!",
                        style: kTitleStyle,
                      ),
                      MiniText(text: "What would you like to order?"),
                      SizedBox(
                        height: 30,
                      ),
                      SearchBox(
                        mealsBloc: mealsBloc,
                      ),
                      ElevatedButton(
                        onPressed: () => Modular.to.pushNamed('/favoriteMeals'),
                        child: Text('favorite'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListMealsWidget(
                        mealsBloc: mealsBloc,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // BlocBuilder<ListMealsBloc, ListMealsState>(
  //         builder: (context, state) {
  //           if (state is Loading) {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           } else if (state is Loaded) {
  //             return ListView.builder(
  //               itemCount: state.meals.length,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   title: Text(state.meals[index].strMeal),
  //                   subtitle: Text(state.meals[index].strCategory),
  //                   onTap: () {
  //                     Modular.to.pushNamed(
  //                       '/detailMeals',
  //                       arguments: state.meals[index],
  //                     );
  //                   },
  //                 );
  //               },
  //             );
  //           } else if (state is Error) {
  //             return Text(state.message);
  //           } else {
  //             return SizedBox.shrink();
  //           }
  //         },
  //       ),
}

class SearchBox extends StatelessWidget {
  final ListMealsBloc mealsBloc;

  const SearchBox({Key key, @required this.mealsBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextFormField(
        onChanged: (val) {
          print(val);
          mealsBloc.add(GetListMeals(val));
        },
        decoration: InputDecoration(
          hintText: "Search Food or Cafes near you",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AppIcons extends StatelessWidget {
  final IconData icon;
  final Color color;
  AppIcons({this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.3),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}

class MiniText extends StatelessWidget {
  final String text;
  MiniText({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w700,
          color: titleColor.withOpacity(0.5),
          fontSize: 18,
        ));
  }
}
