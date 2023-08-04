import 'package:flutter/material.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatefulWidget {
  final String text;
  final String title;
  final IconData icon;
  const UserInfoWidget({Key? key, required this.text, required this.title, required this.icon}) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child)
    {
      return Padding(
        padding:  EdgeInsets.only(
            left: sizeFromWidth(context, 20),
            top: sizeFromHeight(context, 50),
            bottom: sizeFromHeight(context, 50)),
        child: Row(
          children: [
            Icon(widget.icon,
                size:
                sizeFromWidth(context, 15),
                color: themeNotifier.isDark
                    ? Colors.white
                    : Colors.grey.shade700),
            SizedBox(
              width: sizeFromWidth(context, 10),
            ),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: sizeFromWidth(
                          context, 20),
                      fontWeight:
                      FontWeight.w900,
                      color:
                      themeNotifier.isDark
                          ? Colors.white
                          : Colors.grey
                          .shade700),
                ),
                Text(
                  widget.text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: sizeFromWidth(
                          context, 20),
                      fontWeight:
                      FontWeight.w900,
                      color:
                      themeNotifier.isDark
                          ? Colors.white
                          : Colors.grey
                          .shade500),
                ),
              ],
            ),
          ],
        ),
      );
    },
    );
  }
}
