import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meals/feature/meals/presentation/bloc/list_meals_bloc/list_meals_bloc.dart';
import 'package:flutter_meals/feature/meals/presentation/pages/meals_homepage.dart';
import 'package:flutter_meals/shared/colors.dart';
import 'package:flutter_meals/shared/text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class ListMealsWidget extends StatelessWidget {
  final ListMealsBloc mealsBloc;

  const ListMealsWidget({
    Key key,
    @required this.mealsBloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Orders",
                style: kSubTitleStyle,
              ),
              Spacer(),
              MiniText(
                text: "More",
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<ListMealsBloc, ListMealsState>(
            builder: (context, state) {
              if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                return state.meals.length == null
                    ? Text('Data Not Found')
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.meals.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 320,
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Modular.to.pushNamed(
                                        '/detailMeals',
                                        arguments: state.meals[index],
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(state
                                                      .meals[index]
                                                      .strMealThumb),
                                                  // fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${state.meals[index].strMeal}',
                                                style: GoogleFonts.nunitoSans(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: titleColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              MiniText(
                                                text:
                                                    "${state.meals[index].strCategory}",
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'From ${state.meals[index].strArea}',
                                                style: GoogleFonts.nunitoSans(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20),
                                            Icon(
                                              Icons.bookmark,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                      );
              } else if (state is Error) {
                return Text(state.message);
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
