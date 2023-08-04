import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/const/common/colors.dart';
import 'package:project07/presentation/widgets/post.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return BlocProvider(
          create: (BuildContext context) => AppCubit()..getFavPosts(),
          child: BlocConsumer<AppCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: themeNotifier.isDark
                          ? Color(0xFF0E0E0F)
                          : Color(0xFFFFFFFF),
                      elevation: 0.0,
                      title: Text(
                        FirebaseAuth.instance.currentUser!.uid.toString() ==
                                systemID
                            ? 'All Quotes'
                            : 'Favorite Quotes',
                        style: TextStyle(
                          color: themeNotifier.isDark ? whiteColor : blackColor,
                          fontSize: sizeFromWidth(context, 14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    extendBody: true,
                    body: FirebaseAuth.instance.currentUser!.uid.toString() ==
                            systemID
                        ? SystemAllQuotesScreen()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 15)),
                            child: SingleChildScrollView(
                              child: ConditionalBuilder(
                                condition:
                                    AppCubit.get(context).posts.isNotEmpty,
                                builder: (context) => Column(
                                  children: [
                                    FavPost(
                                      postModel: AppCubit.get(context).posts,
                                      isArabic: AppCubit.get(context).isArabic,
                                    ),
                                  ],
                                ),
                                fallback: (context) => Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: mainColor,
                                        size: sizeFromHeight(context, 20),
                                      ),
                                      SizedBox(
                                        height: sizeFromHeight(context, 30),
                                      ),
                                      Text(
                                        'There are no quotes yet',
                                        style: TextStyle(
                                            fontSize: sizeFromWidth(context, 18), color: mainColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
              }));
    });
  }
}

class SystemAllQuotesScreen extends StatelessWidget {
  const SystemAllQuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return BlocProvider(
          create: (BuildContext context) => AppCubit()..getPosts(),
          child: BlocConsumer<AppCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: SingleChildScrollView(
                    child: ConditionalBuilder(
                      condition: AppCubit.get(context).posts.isNotEmpty,
                      builder: (context) => Column(
                        children: [
                          PostForAdmin(
                            postModel: AppCubit.get(context).posts,
                          ),
                        ],
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
