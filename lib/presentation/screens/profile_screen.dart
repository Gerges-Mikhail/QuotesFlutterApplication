import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/const/common/colors.dart';
import 'package:project07/presentation/widgets/userInfo.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return BlocProvider(
        create: (BuildContext context) => AppCubit()..getUserData(),
        child: BlocConsumer<AppCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  themeNotifier.isDark ? "Dark Mode" : "Light Mode",
                  style: TextStyle(
                      fontSize: sizeFromWidth(context, 18),
                      color: themeNotifier.isDark
                          ? Colors.white
                          : Colors.grey.shade900),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                          themeNotifier.isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny,
                          size: sizeFromWidth(context, 15),
                          color: themeNotifier.isDark
                              ? Colors.white
                              : Colors.grey.shade900),
                      onPressed: () {
                        themeNotifier.isDark
                            ? themeNotifier.isDark = false
                            : themeNotifier.isDark = true;
                      })
                ],
              ),
              body: FirebaseAuth.instance.currentUser!.uid.toString() ==
                      systemID
                  ? SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        Padding(
                          padding:  EdgeInsets.only(
                              top: sizeFromHeight(context, 30),
                              right: sizeFromWidth(context, 60),
                              left: sizeFromWidth(context, 30)),                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Admin',
                                    style: TextStyle(
                                        fontSize: sizeFromWidth(context, 12),
                                        fontWeight: FontWeight.w900,
                                        color: themeNotifier.isDark
                                            ? Colors.white
                                            : Colors.grey.shade900),
                                  )
                                ],
                              ),
                              Divider(
                                color: secondColor,
                                thickness: 1.5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(context, 2),
                              ),
                              SizedBox(
                                width: 150,
                                child: RaisedButton(
                                  onPressed: () => {
                                    AppCubit.get(context).logout(context),
                                    showToast(
                                        state: ToastStates.SUCCESS,
                                        text: 'Logout Successfully'),
                                  },
                                  elevation: 0,
                                  padding: const EdgeInsets.all(18),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                      child: Text(
                                    "Logout",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]))
                  : SingleChildScrollView(
                      physics:  BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ConditionalBuilder(
                            condition:
                                AppCubit.get(context).modelProfile != null,
                            builder: (context) => Padding(
                              padding:  EdgeInsets.only(
                                  top: sizeFromHeight(context, 30),
                                  right: sizeFromWidth(context, 60),
                                  left: sizeFromWidth(context, 30)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppCubit.get(context)
                                            .modelProfile!
                                            .name
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize:
                                                sizeFromWidth(context, 12),
                                            fontWeight: FontWeight.w900,
                                            color: themeNotifier.isDark
                                                ? Colors.white
                                                : Colors.grey.shade900),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: secondColor,
                                    thickness: 1.5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      UserInfoWidget(text: AppCubit
                                          .get(context)
                                          .modelProfile!
                                          .email, title: 'Email', icon: Icons.alternate_email),
                                      Divider(
                                        indent: 20,
                                        endIndent: 20,
                                        color: secondColor,
                                        thickness: 1.5,
                                      ),
                                      UserInfoWidget(text: AppCubit
                                          .get(context)
                                          .modelProfile!
                                          .phone, title: 'Phone Number', icon: Icons.phone),
                                      Divider(
                                        indent: 20,
                                        endIndent: 20,
                                        color: secondColor,
                                        thickness: 1.5,
                                      ),
                                      UserInfoWidget(text: AppCubit
                                          .get(context)
                                          .modelProfile!
                                          .age, title: 'Age', icon: Icons.person),
                                      Divider(
                                        indent: 20,
                                        endIndent: 20,
                                        color: secondColor,
                                        thickness: 1.5,
                                      ),
                                      UserInfoWidget(text: AppCubit
                                          .get(context)
                                          .modelProfile!
                                          .gender, title: 'Gender', icon: Icons.male),
                                    ],
                                  ),
                                  SizedBox(
                                    height: sizeFromHeight(context, 13),
                                  ),
                                  SizedBox(
                                    width: sizeFromWidth(context, 4),
                                    child: RaisedButton(
                                      onPressed: () => {
                                        AppCubit.get(context).logout(context),
                                        showToast(
                                            state: ToastStates.SUCCESS,
                                            text: 'Logout Successfully'),
                                      },
                                      elevation: 0,
                                      padding: EdgeInsets.all(
                                          sizeFromWidth(context, 25)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  sizeFromWidth(context, 20))),
                                      child: const Center(
                                          child: Text(
                                        "Logout",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      );
    });
  }
}
