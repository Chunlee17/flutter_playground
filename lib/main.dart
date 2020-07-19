import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:flutter_playground/models/contact.dart';
import 'package:flutter_playground/bloc_provider_get_controller/counter_model.dart';
import 'package:flutter_playground/pages/home_page.dart';
import 'package:flutter_playground/bloc_provider_get_controller/counter_provider.dart';
import 'package:flutter_playground/bloc_provider_get_controller/proxy_state_provider.dart';
import 'package:flutter_playground/bloc_provider_get_controller/todo_db_provider.dart';
import 'package:flutter_playground/widgets/counter_inherited_widget.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:momentum/momentum.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc_provider_get_controller/counter_bloc.dart';
import 'bloc_provider_get_controller/counter_stream.dart';
import 'bloc_provider_get_controller/momentum/momentum_counter.dart';
import 'bloc_provider_get_controller/todo_bloc.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupHive();
  getIt.registerLazySingleton(() => CounterBloc(0));
  getIt.registerLazySingleton(() => TodoDBProvider());
  getIt.registerLazySingleton(() => TodoBloc());
  return runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('km', 'KH')],
      path: 'resources/language',
    ),
  );
}

void setupHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  //Hive.init(appDocumentDir.path);
  //Hive.registerAdapter(ContactAdapter());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AudioServiceWidget(
      child: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(0),
        child: CounterInherited(
          count: 20,
          child: MultiProvider(
            providers: [
              InheritedProvider(create: (context) => 20),
              ChangeNotifierProvider(create: (_) => CounterProvider()),
              Provider(create: (context) => CheckNumberProvider()),
              Provider(create: (context) => CounterStream()),
              ProxyProvider<CounterProvider, CheckNumberProvider>(
                update: (context, counter, depender) =>
                    CheckNumberProvider(counter: counter),
              ),
            ],
            child: Momentum(
              controllers: [
                MomentumCounterController(),
              ],
              child: GetMaterialApp(
                title: 'Flutter Playground',
                navigatorKey: JinNavigator.navigatorKey,
                debugShowCheckedModeBanner: false,
                enableLog: false,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  EasyLocalization.of(context).delegate,
                ],
                supportedLocales: EasyLocalization.of(context).supportedLocales,
                locale: EasyLocalization.of(context).locale,
                theme: ThemeData(
                  primarySwatch: primaryColor,
                  accentColor:
                      JinColorUtils.hexColorToMaterialColor(0xFF47C5FB),
                ),
                home: MyHomePage(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
