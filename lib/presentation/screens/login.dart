import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/presentation/screens/signup.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                body: SingleChildScrollView(
                  child: Container(
                    width: sizeFromWidth(context, 1),
                    height: sizeFromHeight(context, 1),
                    padding: EdgeInsets.only(
                        left: sizeFromWidth(context,20),
                        right: sizeFromWidth(context,20),
                        bottom: sizeFromHeight(context, 5),
                        top: sizeFromHeight(context, 10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello, \nWelcome Back",
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: sizeFromWidth(context, 12),
                                    )),
                        Form(
                          key: AppCubit.get(context).formKeyLogin,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: sizeFromHeight(context, 20),
                              ),
                              Container(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: sizeFromWidth(context, 18),
                                    vertical: sizeFromHeight(context, 120)),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(sizeFromWidth(context, 15)))),
                                child: TextFormField(
                                  controller:
                                      AppCubit.get(context).emailLogin,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email can not empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email or Phone number"),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                               SizedBox(
                                height: sizeFromHeight(context, 60),
                              ),
                              Container(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: sizeFromWidth(context, 18),
                                    vertical: sizeFromHeight(context, 120)
                                ),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(sizeFromWidth(context, 15)))),
                                child: TextFormField(
                                  controller: AppCubit.get(context).passwordLogin,
                                  validator: (v) {
                                    if (v!.isEmpty) return 'password required';
                                    if (v.length < 8 ) return 'password short';
                                    return null;
                                  },
                                  obscureText: AppCubit.get(context).isPassword,
                                  decoration: InputDecoration(
                                      suffixIcon: AppCubit.get(context).isPassword ?
                                      GestureDetector(
                                        onTap: (){
                                          AppCubit.get(context).changePasswordVisibility();
                                        },
                                        child: Icon(
                                              Icons.visibility_off_outlined,
                                              size: sizeFromWidth(context, 18),
                                              color: themeNotifier.isDark
                                                  ? Colors.white
                                                  : Colors.grey.shade900,
                                        ),
                                      ) : GestureDetector(
                                        onTap: (){
                                          AppCubit.get(context).changePasswordVisibility();
                                        },
                                        child: Icon(
                                          Icons.visibility_outlined,
                                          size: sizeFromWidth(context, 18),
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
                              Text(
                                "Forgot Password?",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              onPressed: () => {
                                if (AppCubit.get(context)
                                    .formKeyLogin
                                    .currentState!
                                    .validate())
                                  {
                                    AppCubit.get(context).userLogin(
                                      email: AppCubit.get(context)
                                          .emailLogin
                                          .text
                                          .trim(),
                                      password: AppCubit.get(context)
                                          .passwordLogin
                                          .text
                                          .trim(),
                                      context: context,
                                    ),
                                    AppCubit.get(context).getUid(),
                                  },
                              },
                              elevation: 0,
                              padding: const EdgeInsets.all(18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: sizeFromWidth(context, 20),
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                             SizedBox(
                              height: sizeFromHeight(context, 40),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        SignUpPage(),
                                  ),
                                );
                              },
                              child: Text("Create an account",
                                  style: Theme.of(context).textTheme.bodyText1),
                            )
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
