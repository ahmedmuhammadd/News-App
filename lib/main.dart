import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/cubit_status.dart';
import 'package:newsapp/layout/home_screen.dart';
import 'package:newsapp/layout/provider.dart';
import 'package:newsapp/shared/networks/remote.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/shared/themes/dark_theme.dart';
import 'package:newsapp/shared/themes/light_theme.dart';
import 'package:provider/provider.dart';
import 'shared/block_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  bool fromShared = await NewsCubit().getThemeMode();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                HomeProvider()..changeDarkMode(fromShared: fromShared))
      ],
      child: MyApp(fromShared: fromShared),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool fromShared;
  const MyApp({Key key, this.fromShared}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, CubitStatus>(
          listener: (context, status) {},
          builder: (context, status) {
            return Consumer<HomeProvider>(
              builder: (context, value, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  home: const HomeScreen(),
                );
              },
            );
          }),
    );
  }
}
