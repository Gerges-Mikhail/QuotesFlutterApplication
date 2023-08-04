import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/data/models/postByAdmin.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Post extends StatefulWidget {
  final List<PostByAdminModel> postModel;
  final bool isArabic;
  Post({
    Key? key,
    required this.postModel, required this.isArabic,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  List<Function> shareBtn = <Function>[];
  List<Color> colorsList1 = [];
  IconData liked = Icons.favorite_border;
  List<Color> colors1 = [
    Color(0xFFA1CCD1),
    Color(0xFFE9B384),
    Color(0xFFEAB2A0),
    Color(0xFF7C9D96),
    Color(0xFF967E76),
    Color(0xFFAF7AB3),
    Color(0xFFFF6363),
    Color(0xFF4C6C96),
  ];

  List<Color> colors2 = [
    Color(0xFFA1CCD1),
    Color(0xFFE9B384),
    Color(0xFFEAB2A0),
    Color(0xFF7C9D96),
    Color(0xFF967E76),
    Color(0xFFAF7AB3),
    Color(0xFFFF6363),
    Color(0xFF4C6C96),
  ];
  Random random = Random();
  FlutterTts flutterTts = FlutterTts();

  Future _speak(String text) async {
    await flutterTts.setLanguage("en_US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(text);
  }

  Future _stop() async {
    await flutterTts.stop();
  }
  @override
  Widget build(BuildContext context) {
    int randomIndex = random.nextInt(colors1.length);
    int randomIndex2 = random.nextInt(colors2.length);
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: widget.postModel.asMap().entries.map((entry) {
                PostByAdminModel postModel = entry.value;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          randomIndex = randomIndex2;
                        });
                      },
                      child: Flexible(
                        child: Container(
                          //height: sizeFromHeight(context, 6),
                          // width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: sizeFromWidth(context, 15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(sizeFromWidth(context, 30)),
                              child: Text(
                                postModel.name,
                                textAlign: widget.isArabic? TextAlign.left : TextAlign.right,
                                style: TextStyle(
                                  fontSize: sizeFromWidth(context, 20),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colors1[randomIndex],
                            ),
                            gradient: LinearGradient(stops: [
                              0.05,
                              0.02
                            ], colors: [
                              colors1[randomIndex],
                              colors2[randomIndex2].withOpacity(.5)
                            ]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(sizeFromWidth(context, 30))),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context).setFavPosts(
                                  postModel.name, postModel.language);
                              showToast(
                                  state: ToastStates.SUCCESS,
                                  text: 'Add to fav screen Successfully');
                            },
                            icon:
                            Icon(
                              Icons.add,
                              color: themeNotifier.isDark
                                  ? Colors.white
                                  : colors1[randomIndex],
                            )),
                        IconButton(
                            onPressed: () async {
                              await Share.share(postModel.name);
                            },
                            icon: Icon(
                              Icons.send,
                              color: colors2[randomIndex2].withOpacity(0.5),
                            )),
                        IconButton(
                            onPressed: () async {
                              await _speak(postModel.name);
                              widget.isArabic?  null: _speak("please,change phone language to arabic");
                            },
                            icon: Icon(
                              Icons.record_voice_over,
                              color: colors2[randomIndex2].withOpacity(0.5),
                            )),
                      ],
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      );
    });
  }
}
class FavPost extends StatefulWidget {
  final List<PostByAdminModel> postModel;
  final bool isArabic;
  FavPost({
    Key? key,
    required this.postModel, required this.isArabic,
  }) : super(key: key);

  @override
  State<FavPost> createState() => _FavPostState();
}

class _FavPostState extends State<FavPost> {
  List<bool> _isLiked = <bool>[];
  List<Function> shareBtn = <Function>[];
  List<Color> colorsList1 = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.postModel.length; i++) {
      _isLiked.add(false);
    }
  }

  List<Color> colors1 = [
    Color(0xFFA1CCD1),
    Color(0xFFE9B384),
    Color(0xFFEAB2A0),
    Color(0xFF7C9D96),
    Color(0xFF967E76),
    Color(0xFFAF7AB3),
    Color(0xFFFF6363),
    Color(0xFF4C6C96),
  ];

  List<Color> colors2 = [
    Color(0xFFA1CCD1),
    Color(0xFFE9B384),
    Color(0xFFEAB2A0),
    Color(0xFF7C9D96),
    Color(0xFF967E76),
    Color(0xFFAF7AB3),
    Color(0xFFFF6363),
    Color(0xFF4C6C96),
  ];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    int randomIndex = random.nextInt(colors1.length);
    int randomIndex2 = random.nextInt(colors2.length);
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: widget.postModel.asMap().entries.map((entry) {
                PostByAdminModel postModel = entry.value;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          randomIndex = randomIndex2;
                        });
                      },
                      child: Flexible(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: sizeFromWidth(context, 15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(sizeFromWidth(context, 30)),
                              child: Text(
                                postModel.name,
                                textAlign: widget.isArabic ? TextAlign.center : TextAlign.center,
                                style: TextStyle(
                                  fontSize: sizeFromWidth(context, 20),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colors1[randomIndex],
                            ),
                            gradient: LinearGradient(stops: [
                              0.05,
                              0.02
                            ], colors: [
                              colors1[randomIndex],
                              colors2[randomIndex2].withOpacity(.5)
                            ]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(sizeFromWidth(context, 30))),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context)
                                  .deleteFavPost(postModel.id);
                              showToast(
                                  state: ToastStates.SUCCESS,
                                  text: 'Quote Deleted');
                            },
                            icon:  Icon(
                                  Icons.delete,
                                  color: colors1[randomIndex],
                                )),
                        IconButton(
                            onPressed: () async {
                              await Share.share(postModel.name);
                            },
                            icon: Icon(
                              Icons.send,
                              color: colors2[randomIndex2].withOpacity(0.5),
                            )),
                      ],
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      );
    });
  }
}

class PostForAdmin extends StatefulWidget {
  final List<PostByAdminModel> postModel;

  PostForAdmin({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<PostForAdmin> createState() => _PostForAdminState();
}

class _PostForAdminState extends State<PostForAdmin> {
  List<bool> _isLiked = <bool>[];
  List<Function> shareBtn = <Function>[];
  List<Color> colorsList1 = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.postModel.length; i++) {
      _isLiked.add(false);
    }
    for (int s = 0; s < widget.postModel.length; s++) {
      shareBtn.add(() {
        print('shared');
      });
    }
  }

  List<Color> colors1 = [
    Color(0xFFA1CCD1),
    Color(0xFFE9B384),
    Color(0xFFEAB2A0),
    Color(0xFF7C9D96),
    Color(0xFF967E76),
    Color(0xFFAF7AB3),
    Color(0xFFFF6363),
    Color(0xFF4C6C96),
  ];

  List<Color> colors2 = [
    Color(0xFFA1CCD1),
    Color(0xFFE9B384),
    Color(0xFFEAB2A0),
    Color(0xFF7C9D96),
    Color(0xFF967E76),
    Color(0xFFAF7AB3),
    Color(0xFFFF6363),
    Color(0xFF4C6C96),
  ];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    int randomIndex = random.nextInt(colors1.length);
    int randomIndex2 = random.nextInt(colors2.length);
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return BlocProvider(
          create: (BuildContext context) => AppCubit()..getPosts(),
          child: BlocConsumer<AppCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: widget.postModel.asMap().entries.map((entry) {
                    int index = entry.key;
                    PostByAdminModel postModel = entry.value;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              randomIndex = randomIndex2;
                            });
                          },
                          child: Flexible(
                            child: Container(
                              //height: sizeFromHeight(context, 6),
                              // width: double.infinity,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: sizeFromWidth(context, 15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(sizeFromWidth(context, 35)),
                                    child: Text(
                                      postModel.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors1[randomIndex],
                                ),
                                gradient: LinearGradient(stops: [
                                  0.05,
                                  0.02
                                ], colors: [
                                  colors1[randomIndex],
                                  colors2[randomIndex2].withOpacity(.5)
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(sizeFromWidth(context, 30))),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isLiked[index] = !_isLiked[index];
                                });
                              },
                              icon: _isLiked[index]
                                  ? Icon(
                                      Icons.favorite,
                                      color: themeNotifier.isDark
                                          ? Colors.white
                                          : colors1[randomIndex],
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: themeNotifier.isDark
                                          ? Colors.white
                                          : colors1[randomIndex],
                                    ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await Share.share(postModel.name);
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: colors2[randomIndex2].withOpacity(0.5),
                                )),
                            IconButton(
                                onPressed: () {
                                  //await Share.share(postModel.name);
                                  AppCubit.get(context)
                                      .deletePost(postModel.id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: colors2[randomIndex2].withOpacity(0.5),
                                )),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                );
              }));
    });
  }
}
