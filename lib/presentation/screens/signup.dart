import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/presentation/screens/login.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return BlocProvider(
          create: (BuildContext context) => AppCubit(),
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
                body: Padding(
                  padding: EdgeInsets.only(
                      left: sizeFromWidth(context, 18),
                      right: sizeFromWidth(context, 18),
                      // bottom: size.height * 0.2,
                      top: sizeFromHeight(context, 30)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Welcome \nCreate your account",
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: sizeFromWidth(context, 12),
                                    )),
                         SizedBox(
                          height: sizeFromHeight(context, 30),
                        ),
                        Form(
                          key: AppCubit.get(context).formKeySignUp,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //name text form field
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller:
                                        AppCubit.get(context).nameSignUp,
                                    validator: (v) {
                                      if (v!.isEmpty) return 'name required';
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name"),
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                 SizedBox(
                                  height: sizeFromHeight(context, 60),
                                ),
                                //email text form field
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller:
                                        AppCubit.get(context).emailSignUp,
                                    validator: (v) {
                                      if (v!.isEmpty) return 'email required';
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email"),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                 SizedBox(
                                  height: sizeFromHeight(context, 60),
                                ),
                                //password text form field
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller:
                                        AppCubit.get(context).passwordSignUp,
                                    validator: (v) {
                                      if (v!.isEmpty)
                                        return 'password required';
                                      if (v.length < 8)
                                        return 'password is weak';
                                      return null;
                                    },
                                    obscureText:
                                        AppCubit.get(context).isPassword,
                                    decoration: InputDecoration(
                                        suffixIcon: AppCubit.get(context)
                                                .isPassword
                                            ? GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .changePasswordVisibility();
                                                },
                                                child: Icon(
                                                  Icons.visibility_off_outlined,
                                                  color: themeNotifier.isDark
                                                      ? Colors.white
                                                      : Colors.grey.shade900,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .changePasswordVisibility();
                                                },
                                                child: Icon(
                                                  Icons.visibility_outlined,
                                                  color: themeNotifier.isDark
                                                      ? Colors.white
                                                      : Colors.grey.shade900,
                                                ),
                                              ),
                                        border: InputBorder.none,
                                        hintText: "Password"),
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                                 SizedBox(
                                   height: sizeFromHeight(context, 60),
                                ),
                                //confirm password text form field
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller: AppCubit.get(context)
                                        .confirmPasswordSignUp,
                                    validator: (v) {
                                      if (v!.isEmpty)
                                        return 'confirm password required';
                                      if (AppCubit.get(context)
                                              .confirmPasswordSignUp
                                              .text !=
                                          AppCubit.get(context)
                                              .passwordSignUp
                                              .text)
                                        return 'password not match';
                                      return null;
                                    },
                                    obscureText: AppCubit.get(context)
                                        .isConfirmPassword,
                                    decoration: InputDecoration(
                                        suffixIcon: AppCubit.get(context)
                                                .isConfirmPassword
                                            ? GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .changeConfirmPasswordVisibility();
                                                },
                                                child: Icon(
                                                  Icons.visibility_off_outlined,
                                                  color: themeNotifier.isDark
                                                      ? Colors.white
                                                      : Colors.grey.shade900,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .changeConfirmPasswordVisibility();
                                                },
                                                child: Icon(
                                                  Icons.visibility_outlined,
                                                  color: themeNotifier.isDark
                                                      ? Colors.white
                                                      : Colors.grey.shade900,
                                                ),
                                              ),
                                        border: InputBorder.none,
                                        hintText: "Confirm Password"),
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                                 SizedBox(
                                  height: 20,
                                ),
                                //age
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller:
                                        AppCubit.get(context).ageSignUp,
                                    validator: (v) {
                                      if (v!.isEmpty) return 'age required';
                                      if (v.length > 50)
                                        return 'invalid age must be 50 or lower';
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Age"),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                 SizedBox(
                                   height: sizeFromHeight(context, 60),
                                ),
                                //phone Number
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller:
                                        AppCubit.get(context).phoneSignUp,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'phone can not empty';
                                      } else if (value.length > 11) {
                                        return 'phone number must consist of 11 ';
                                      } else if (value.length < 11) {
                                        return 'phone number must consist of 11 ';
                                      }
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone Number"),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                                 SizedBox(
                                   height: sizeFromHeight(context, 60),
                                ),
                                //gender
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: sizeFromWidth(context, 20), vertical: sizeFromHeight(context, 100)),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(sizeFromWidth(context, 20)))),
                                  child: TextFormField(
                                    controller:
                                        AppCubit.get(context).genderSignUp,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Gender can not empty';
                                      } else if (value != 'male' &&
                                          value != 'female') {
                                        return 'Gender male or female';
                                      }
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Gender"),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                 SizedBox(
                                   height: sizeFromHeight(context, 60),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              onPressed: () => {
                                if (AppCubit.get(context)
                                    .formKeySignUp
                                    .currentState!
                                    .validate())
                                  {
                                    AppCubit.get(context).userRegister(
                                      name: AppCubit.get(context)
                                          .nameSignUp
                                          .text
                                          .trim(),
                                      phone: AppCubit.get(context)
                                          .phoneSignUp
                                          .text
                                          .trim(),
                                      email: AppCubit.get(context)
                                          .emailSignUp
                                          .text
                                          .trim(),
                                      password: AppCubit.get(context)
                                          .passwordSignUp
                                          .text
                                          .trim(),
                                      context: context,
                                      age: AppCubit.get(context)
                                          .ageSignUp
                                          .text
                                          .trim(),
                                      gender: AppCubit.get(context)
                                          .genderSignUp
                                          .text
                                          .trim(),
                                    ),
                                    print('account created'),
                                  }
                                else
                                  {
                                    showToast(
                                        text: 'Try again,and enter right data',
                                        state: ToastStates.ERROR),
                                  }
                              },
                              elevation: 0,
                              padding:  EdgeInsets.all(sizeFromWidth(context, 20)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(sizeFromWidth(context, 20))),
                              child:  Center(
                                  child: Text(
                                "Signup",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                             SizedBox(
                               height: sizeFromHeight(context, 60),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          LoginPage(),
                                    ),
                                  );
                                },
                                child: Text("Have An Account",
                                    style:
                                        Theme.of(context).textTheme.bodyText1)),
                             SizedBox(
                               height: sizeFromHeight(context, 60),
                            ),
                          ],
                        )
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
