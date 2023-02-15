import 'package:flutter/material.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/cubit_status.dart';
import 'package:newsapp/shared/componant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppleScreen extends StatelessWidget {
  const AppleScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, CubitStatus>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = NewsCubit.get(context);
          if (states is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return cubit.apple.isEmpty
                ? Center(
                    child: Text(
                      "Waiting For The Network!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildArticleItem(cubit.apple[index], context);
                    },
                    separatorBuilder: (context, index) => buildDivider(),
                    itemCount: cubit.apple.length);
          }
        });
  }
}
