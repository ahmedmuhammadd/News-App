import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/cubit_status.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen(this.url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<NewsCubit, CubitStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            return WebView(
              initialUrl: url,
            );
          },
        ));
  }
}
