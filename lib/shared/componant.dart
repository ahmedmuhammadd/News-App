import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view.dart';

Widget defaultButton(
        {double width = double.infinity,
        double radius = 0.0,
        Color background = Colors.blue,
        bool isUppercase = true,
        @required String text,
        @required Function function}) =>
    Container(
      width: width,
      child: MaterialButton(
        child: Text(
          isUppercase ? text.toLowerCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultFormField({
  TextInputType keyboardType,
  Function validator,
  Function onChanged,
  Function onTap,
  Function onFieldSubmitted,
  @required TextEditingController controller,
  @required String labelText,
  @required IconData prefix,
}) =>
    TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: (s) => validator(s),
      onChanged: (value) {
        onChanged(value);
      },
      onTap: () {
        onTap();
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted(value);
      },
      decoration: InputDecoration(
        prefix: Icon(prefix),
        labelText: labelText,
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

Widget buildArticleItem(artical, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(artical['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  onError: ((exception, stackTrace) {
                    return const Text('No Image Here!');
                  }),
                  image: NetworkImage(artical['urlToImage']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${artical['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${artical['publishedAt']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.grey),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 20),
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
