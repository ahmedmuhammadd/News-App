import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/cubit_status.dart';
import 'package:newsapp/layout/provider.dart';
import 'package:newsapp/shared/componant.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, CubitStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: value.isDark ? Colors.white : Colors.grey,
                          ),
                        )),
                        controller: searchController,
                        onChanged: (String value) {
                          NewsCubit.get(context).getSearch(value);
                        },
                      );
                    },
                  )),
              Expanded(
                child: NewsCubit.get(context).search.isEmpty
                    ? Text(
                        "Write To Get Some Words to Searvh for",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildArticleItem(
                            NewsCubit.get(context).search[index], context),
                        separatorBuilder: (context, index) => buildDivider(),
                        itemCount: NewsCubit.get(context).search.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
