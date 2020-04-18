import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/bloc/counter_bloc.dart';
import 'package:flutter_playground/bloc/real_counter_bloc.dart';
import 'package:flutter_playground/home_page.dart';
import 'package:flutter_playground/models/counter_model.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton(() => CounterBloc());
  return runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('km', 'KH')],
      path: 'resources/language',
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RealCounterBloc>(
      create: (context) => RealCounterBloc(),
      child: Injector(
          inject: [
            Inject(() => Counter()),
          ],
          builder: (context) {
            return MaterialApp(
              title: 'Flutter Playground',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                EasyLocalization.of(context).delegate,
              ],
              supportedLocales: EasyLocalization.of(context).supportedLocales,
              locale: EasyLocalization.of(context).locale,
              theme: ThemeData(
                primarySwatch: Colors.pink,
              ),
              home: MyHomePage(),
            );
          }),
    );
  }
}
