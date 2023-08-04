import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/const/common/colors.dart';
import 'package:project07/presentation/screens/adminScreen.dart';
import 'package:project07/presentation/widgets/arabicQuotes.dart';
import 'package:project07/presentation/widgets/englishQoutes.dart';
import 'package:project07/presentation/widgets/post.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool arabic = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return BlocProvider(
          create: (BuildContext context) => AppCubit()..getEnglishPosts(),
          child: BlocConsumer<AppCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: FirebaseAuth.instance.currentUser!.uid.toString() ==
                    systemID
                    ? AppBar(
                  backgroundColor: themeNotifier.isDark
                      ? Color(0xFF0E0E0F)
                      : Color(0xFFFFFFFF),
                  elevation: 0.0,
                  title: Text(
                    'Admin Screen',
                    style: TextStyle(
                      color: themeNotifier.isDark ? whiteColor : blackColor,
                      fontSize: sizeFromWidth(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ):
                AppBar(
                  backgroundColor: themeNotifier.isDark
                      ? Color(0xFF0E0E0F)
                      : Color(0xFFFFFFFF),
                  elevation: 0.0,
                  title: Text(
                    'Q  U  O  T  E  S',
                    style: TextStyle(
                      color: themeNotifier.isDark ? whiteColor : blackColor,
                      fontSize: sizeFromWidth(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  leading: Padding(
                    padding: EdgeInsets.only(
                        left: sizeFromWidth(context, 20),
                        top: sizeFromHeight(context, 60),
                        bottom: sizeFromHeight(context, 60)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          AppCubit.get(context).changeArabic();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: themeNotifier.isDark
                                  ? whiteColor
                                  : blackColor,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(sizeFromWidth(context, 30)))),
                        child: Center(
                          child: Text(
                            AppCubit.get(context).isArabic ? 'AR' : 'EN',
                            style: TextStyle(
                              color: themeNotifier.isDark
                                  ? whiteColor
                                  : blackColor,
                              fontSize: sizeFromWidth(context, 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                extendBody: false,
                body: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeFromWidth(context, 25),
                          right: sizeFromWidth(context, 25)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeFromWidth(context, 18),
                            vertical: sizeFromHeight(context, 120)),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.all(
                                Radius.circular(sizeFromWidth(context, 15)))),
                        child: TextFormField(
                          controller:
                              AppCubit.get(context).searchPostController,
                          onTap: () {
                            AppCubit.get(context).getPosts();
                          },
                          onChanged: (value) {
                            if (AppCubit.get(context).searchPostController.text ==
                                '' || AppCubit.get(context).posts.isEmpty) {
                              AppCubit.get(context).getEnglishPosts();
                            }
                            AppCubit.get(context).searchAboutPosts(value);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            suffixIcon: Icon(Icons.search),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeFromWidth(context, 150),
                              vertical: sizeFromHeight(context, 10)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FirebaseAuth.instance.currentUser!.uid.toString() ==
                                    systemID
                                ? AdminScreen()
                                : AppCubit.get(context).isArabic
                                    ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 35)),
                          child: ConditionalBuilder(
                              condition: AppCubit.get(context)
                                  .posts
                                  .isNotEmpty,
                              builder: (context) =>
                                  SingleChildScrollView(
                                    child: Post(
                                      postModel:
                                      AppCubit.get(context)
                                          .posts,
                                      isArabic: AppCubit.get(context).isArabic,
                                    ),
                                  ),
                              fallback: (context) => Center(
                                child:
                                CircularProgressIndicator(),
                              )),
                        )
                                    : ArabicQuotes(isArabic: AppCubit.get(context).isArabic,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
