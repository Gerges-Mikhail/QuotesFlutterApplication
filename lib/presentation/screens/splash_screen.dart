import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project07/const/common/colors.dart';
import 'package:project07/const/common/text.dart';
import 'package:project07/presentation/screens/fav_screen.dart';
import 'package:project07/presentation/screens/home_screen.dart';
import 'package:project07/presentation/screens/login.dart';
import 'package:project07/presentation/screens/profile_screen.dart';
import 'package:project07/presentation/screens/signup.dart';
import 'package:project07/presentation/widgets/navbar.dart';
import 'package:project07/size/size.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreenTimer() async {
    Timer(const Duration(seconds: 2), () {
      if(firebaseAuth.currentUser != null)
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> CustomNavigationBarScreen()),(route) {
          return false;
        },);
      }
      else
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>  LoginPage()),(route) {
          return false;
        },);

      }
    });

  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //Image.asset('assets/images/peakpx.jpg',width: sizeFromWidth(context, 1),),
          Center(child: Image.asset('assets/images/pngegg 1.png',)),
        ],
      ),
    );
  }
}
