import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/presentation/widgets/post.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class EnglishQuotes extends StatefulWidget {
  final bool isArabic;
  EnglishQuotes({Key? key, required this.isArabic}) : super(key: key);

  @override
  State<EnglishQuotes> createState() => _EnglishQuotesState();
}

class _EnglishQuotesState extends State<EnglishQuotes> {
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
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10),
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
                    isArabic: widget.isArabic,
                  ),
                ),
            fallback: (context) => Center(
              child:
              CircularProgressIndicator(),
            )),
      );
    },),);},);
  }
}
