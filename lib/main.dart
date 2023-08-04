
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project07/presentation/screens/splash_screen.dart';
import 'package:project07/themes/app_theme.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            home: SplashScreen(),
            theme: themeNotifier.isDark ? AppTheme.dark : AppTheme.light,
            debugShowCheckedModeBanner: false,
          );
        }
      )
    )
  );
}
