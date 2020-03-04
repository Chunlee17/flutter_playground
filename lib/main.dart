import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc/counter_bloc.dart';
import 'package:flutter_playground/home_page.dart';
import 'package:flutter_playground/models/counter_model.dart';
import 'package:get_it/get_it.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton(() => CounterBloc());
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject(() => Counter()),
        ],
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Playground',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            home: MyHomePage(),
          );
        });
  }
}
