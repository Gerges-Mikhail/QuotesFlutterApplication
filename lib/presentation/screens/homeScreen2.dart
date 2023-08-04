import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/const/common/colors.dart';
import 'package:project07/data/models/postByAdmin.dart';
import 'package:project07/size/size.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../busness logic/cubit.dart';
import '../../themes/theme_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool liked = false;
  onCliked(){
    setState((){
      liked = !liked;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return BlocProvider(
          create: (BuildContext context) => AppCubit()..getPosts(),
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
                    'Q  U  O  T  E  S',
                    style: TextStyle(
                      color: themeNotifier.isDark ? whiteColor : blackColor,
                      fontSize: sizeFromWidth(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                extendBody: false,
                body: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
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
                          // onChanged: (value) {
                          //   if (AppCubit.get(context)
                          //               .searchPostController
                          //               .text ==
                          //           '' ||
                          //       AppCubit.get(context).postsForUsers.isEmpty) {
                          //     AppCubit.get(context).getPosts();
                          //   }
                          //   AppCubit.get(context).searchAboutPosts(value);
                          // },
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
                          EdgeInsets.symmetric(horizontal: 2, vertical: 70),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FirebaseAuth.instance.currentUser!.uid.toString() ==
                                    systemID
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 50),
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: AppCubit.get(context)
                                            .formKeyCreatePost,
                                        child: Column(
                                          children: [
                                            Container(
                                              height:
                                                  sizeFromHeight(context, 3),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeFromWidth(
                                                      context, 18),
                                                  vertical: sizeFromHeight(
                                                      context, 120)),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeFromWidth(
                                                                  context,
                                                                  15)))),
                                              child: TextFormField(
                                                maxLines: 8,
                                                controller:
                                                    AppCubit.get(context)
                                                        .postController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'post can not empty';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Write a post"),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  sizeFromHeight(context, 40),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeFromWidth(
                                                      context, 18),
                                                  vertical: sizeFromHeight(
                                                      context, 120)),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              sizeFromWidth(
                                                                  context,
                                                                  15)))),
                                              child: TextFormField(
                                                controller:
                                                    AppCubit.get(context)
                                                        .languagePostController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'AR or EN';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Write a language : ar / en"),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  sizeFromHeight(context, 10),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: RaisedButton(
                                                onPressed: () => {
                                                  if (AppCubit.get(context)
                                                      .formKeyCreatePost
                                                      .currentState!
                                                      .validate())
                                                    {
                                                      AppCubit.get(context)
                                                          .setPostByAdmin(),
                                                      showToast(
                                                          state: ToastStates
                                                              .SUCCESS,
                                                          text:
                                                              'created Successfully'),
                                                    }
                                                },
                                                elevation: 0,
                                                padding:
                                                    const EdgeInsets.all(18),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Center(
                                                    child: Text(
                                                  "Share",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: ConditionalBuilder(
                                        condition: AppCubit.get(context)
                                            .posts
                                            .isNotEmpty,
                                        builder: (context) =>
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                //return buildFoodUserItem(AuthenticationCubit.get(context).foodSystem[index] ,context,index);
                                                return Posttss(
                                                    AppCubit.get(context)
                                                        .posts[index],
                                                    context,
                                                    index,
                                                  liked,
                                                  onCliked,
                                                );
                                              },
                                              itemCount: AppCubit.get(context)
                                                  .posts
                                                  .length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      Divider(
                                                thickness: .2,
                                              ),
                                            ),
                                        fallback: (context) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )),
                                  ),
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

Widget Posttss(PostByAdminModel model, context, index,bool isLiked,VoidCallback onLiked) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: blackColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: sizeFromWidth(context, 15),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                model.name,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      Row(
        children: [
          IconButton(
              onPressed: () {
                AppCubit.get(context).setFavPosts(
                    model.name, model.language);
                showToast(
                    state: ToastStates.SUCCESS,
                    text: 'Add to fav screen Successfully');
                // setState((){
                //   liked = Icons.done;
                // });
                onLiked();
              },
              icon:
              Icon(
                isLiked?
                Icons.favorite:Icons.favorite_border,
                // color: themeNotifier.isDark
                //     ? Colors.white
                //     : colors1[randomIndex],
              )),
          IconButton(
              onPressed: () async {
                await Share.share(model.name);
              },
              icon: Icon(
                Icons.send,
                //color: colors2[randomIndex2].withOpacity(0.5),
              )),
        ],
      ),
    ],
  );
}

Widget PostE(PostByAdminModel model, context, index){
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          // setState(() {
          //   randomIndex = randomIndex2;
          // });
        },
        child: Flexible(
          child: Container(
            height: sizeFromHeight(context, 6),
            width: double.infinity,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: sizeFromWidth(context, 15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: mainColor
                    ),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                //color: colors1[randomIndex],
                color: Colors.red,
              ),
              gradient: LinearGradient(stops: [
                0.05,
                0.02
              ], colors: [
                // colors1[randomIndex],
                // colors2[randomIndex2].withOpacity(.5)
                mainColor,
                secondColor,
                thirdColor
              ]),
              borderRadius:
              BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
      Row(
        children: [
          IconButton(
              onPressed: () {
                AppCubit.get(context).setFavPosts(
                    model.name, model.language);
                showToast(
                    state: ToastStates.SUCCESS,
                    text: 'Add to fav screen Successfully');
                // setState((){
                //   liked = Icons.done;
                // });
              },
              icon:
              Icon(
                Icons.favorite_border,
                // color: themeNotifier.isDark
                //     ? Colors.white
                //     : colors1[randomIndex],
              )),
          IconButton(
              onPressed: () async {
                await Share.share(model.name);
              },
              icon: Icon(
                Icons.send,
                //color: colors2[randomIndex2].withOpacity(0.5),
              )),
        ],
      ),
    ],
  );
}