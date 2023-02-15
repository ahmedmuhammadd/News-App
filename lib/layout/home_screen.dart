import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit_status.dart';
import 'package:newsapp/layout/provider.dart';
import 'package:newsapp/modules/searching.dart';
import 'package:newsapp/shared/componant.dart';
import 'package:provider/provider.dart';

import 'cubit/cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getWallStreetScreen()
        ..getAppleScreen()
        ..getTeslaScreen(),
      child: BlocConsumer<NewsCubit, CubitStatus>(
        listener: (context, status) {},
        builder: (context, status) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                'welcome',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 26),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .changeCurrentMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              items: cubit.BottomNItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
            body: cubit.Screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
