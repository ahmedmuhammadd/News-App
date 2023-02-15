// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/layout/cubit/cubit_status.dart';
import 'package:newsapp/modules/wall_street.dart';
import 'package:newsapp/modules/apple.dart';
import 'package:newsapp/modules/tesla_news.dart';
import 'package:newsapp/shared/networks/remote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCubit extends Cubit<CubitStatus> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool waiting = true;
  List<BottomNavigationBarItem> BottomNItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'WallStreetScreen',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.accessibility_new_sharp),
      label: 'News',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.phone_iphone_rounded),
      label: 'Apple',
    ),
  ];
  List<Widget> Screens = [
    WallStreetScreen(),
    TeslaScreen(),
    AppleScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  List<dynamic> wallStreet = [];
  List<dynamic> tesla = [];
  List<dynamic> apple = [];
  List<dynamic> search = [];

  void getWallStreetScreen() {
    emit(NewsLoadingState());
    if (wallStreet.isEmpty) {
      DioHelper.getData(path: 'v2/everything', queryParameters: {
        'domains': 'wsj.com',
        'apiKey': '5336d502dde94ad4899fd683b8117348',
      }).then(
        (value) {
          wallStreet = value.data['articles'];
          emit(NewsSuccessfulState());
        },
      ).catchError(
        (error) {
          emit(NewsErrorState());
          print(error.toString());
        },
      );
    } else {
      emit(NewsSuccessfulState());
    }
  }

  ///news == tesla  //////////////////

  void getTeslaScreen() {
    if (tesla.isEmpty) {
      emit(NewsLoadingState());
      DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
        'sources': 'techcrunch',
        'apiKey': '5336d502dde94ad4899fd683b8117348',
      }).then(
        (value) {
          tesla = value.data['articles'];
          emit(TeslaSuccessfulState());
        },
      ).catchError(
        (error) {
          emit(TeslaErrorState());
          print(error.toString());
        },
      );
    } else {
      emit(TeslaSuccessfulState());
    }
  }

  void getAppleScreen() {
    if (apple.isEmpty) {
      emit(NewsLoadingState());
      DioHelper.getData(path: 'v2/everything', queryParameters: {
        'q': 'apple',
        'from': DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(Duration(days: 3))),
        'to': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'sortBy': 'popularity',
        'apiKey': '5336d502dde94ad4899fd683b8117348',
      }).then(
        (value) {
          apple = value.data['articles'];
          emit(AppleSuccessfulState());
        },
      ).catchError(
        (error) {
          emit(AppleErrorState());
          print(error.toString());
        },
      );
    } else {
      emit(AppleSuccessfulState());
    }
  }

  Future<bool> getThemeMode() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isDark');
  }

  void getSearch(String value) {
    emit(SearchLoadingState());
    DioHelper.getData(
      path: 'v2/everything',
      queryParameters: {
        'q': value,
        'apiKey': '5336d502dde94ad4899fd683b8117348',
      },
    ).then(
      (value) {
        search = value.data['articles'];
        emit(SearchSuccessfulState());
      },
    ).catchError(
      (error) {
        emit(SearchErrorState());
        print(error.toString());
      },
    );
  }
}
