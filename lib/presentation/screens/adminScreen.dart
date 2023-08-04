import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return BlocProvider(
          create: (BuildContext context) => AppCubit()..getEnglishPosts(),
          child: BlocConsumer<AppCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: SingleChildScrollView(
                  child: Form(
                    key: AppCubit.get(context).formKeyCreatePost,
                    child: Column(
                      children: [
                        Container(
                          height: sizeFromHeight(context, 3),
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeFromWidth(context, 18),
                              vertical: sizeFromHeight(context, 120)),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(sizeFromWidth(context, 15)))),
                          child: TextFormField(
                            maxLines: 8,
                            controller: AppCubit.get(context).postController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'post can not empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write a post"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: sizeFromHeight(context, 40),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeFromWidth(context, 18),
                              vertical: sizeFromHeight(context, 120)),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(sizeFromWidth(context, 15)))),
                          child: TextFormField(
                            controller:
                                AppCubit.get(context).languagePostController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'AR or EN';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write a language : ar / en"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: sizeFromHeight(context, 10),
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
                                  AppCubit.get(context).setPostByAdmin(),
                                  showToast(
                                      state: ToastStates.SUCCESS,
                                      text: 'created Successfully'),
                                }
                            },
                            elevation: 0,
                            padding: const EdgeInsets.all(18),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "Share",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
