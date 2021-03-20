import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meals/core/bloc_observer.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app.dart';
import 'app_module.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    ModularApp(
      module: AppModule(),
      child: App(),
    ),
  );
}
