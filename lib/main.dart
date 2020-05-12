import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_playground/bloc/counter_bloc.dart';
import 'package:flutter_playground/bloc/real_counter_bloc.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:flutter_playground/models/contact.dart';
import 'package:flutter_playground/models/counter_model.dart';
import 'package:flutter_playground/pages/home_page.dart';
import 'package:flutter_playground/provider/counter_provider.dart';
import 'package:flutter_playground/widgets/counter_inherited_widget.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:path_provider/path_provider.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupHive();
  getIt.registerLazySingleton(() => CounterBloc());
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
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ContactAdapter());
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
          return CounterInherited(
            count: 20,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => CounterProvider()),
              ],
              child: GetMaterialApp(
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
                  primarySwatch: primaryColor,
                  accentColor: ColorUtils.hexColorToMaterialColor(0xFF47C5FB),
                ),
                home: MyHomePage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
