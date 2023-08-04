import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project07/busness%20logic/cubit.dart';
import 'package:project07/presentation/widgets/post.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class ArabicQuotes extends StatefulWidget {
  final bool isArabic;
   ArabicQuotes({Key? key, required this.isArabic}) : super(key: key);

  @override
  State<ArabicQuotes> createState() => _ArabicQuotesState();
}

class _ArabicQuotesState extends State<ArabicQuotes> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return BlocProvider(
              create: (BuildContext context) => AppCubit()..getArabicPosts(),
              child: BlocConsumer<AppCubit, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: sizeFromWidth(context, 60),
                          vertical: sizeFromHeight(context, 50)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeFromWidth(context, 35), vertical: sizeFromHeight(context, 75)),
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
                            ),
                          ],
                        ),
                      ),
                    );
                  }));});
  }
}