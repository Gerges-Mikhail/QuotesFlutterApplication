import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:project07/data/models/postByAdmin.dart';
import 'package:project07/data/models/posts.dart';
import 'package:project07/data/models/user.dart';
import 'package:project07/presentation/screens/login.dart';
import 'package:project07/presentation/widgets/navbar.dart';
import 'package:project07/size/size.dart';
part 'state.dart';

class AppCubit extends Cubit<AuthState> {
  AppCubit() : super(ProjectInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  String id = '';
  bool isPassword = true;
  bool isConfirmPassword = true;
  var phoneSignUp = TextEditingController();
  var passwordSignUp = TextEditingController();
  var confirmPasswordSignUp = TextEditingController();
  var emailSignUp = TextEditingController();
  var nameSignUp = TextEditingController();
  var ageSignUp = TextEditingController();
  var genderSignUp = TextEditingController();
  var emailLogin = TextEditingController();
  var passwordLogin = TextEditingController();
  var postController = TextEditingController();
  var languagePostController = TextEditingController();
  var searchPostController = TextEditingController();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCreatePost = GlobalKey<FormState>();
  bool isArabic = false;
  List<UserModel> userProfile = [];
  UserModel? modelProfile;
  List<PostByAdminModel> posts = [];
  searchAboutPosts(value) {
    List<PostByAdminModel> searchPosts = [];
    searchPosts = posts.where((element) {
      var searchItem = element.name.toLowerCase();
      return searchItem.contains(value.toString().toLowerCase());
    }).toList();
    posts = [];
    posts = searchPosts;
    emit(SearchPostSucessful());
  }
  void changeArabic(){
    isArabic = ! isArabic;
  }
  void getEnglishPosts() {
     FirebaseFirestore.instance
        .collection('postsByAdmin').where('language', isEqualTo: 'en',)
    //.orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      for (var element in event.docs) {
        posts.add(PostByAdminModel.fromJson(element.data()));
      }
      emit(GetPostsSuccessful());
    });
  }
  void getArabicPosts() {
    FirebaseFirestore.instance
        .collection('postsByAdmin').where('language', isEqualTo: 'ar',)
    //.orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      for (var element in event.docs) {
        posts.add(PostByAdminModel.fromJson(element.data()));
      }
      emit(GetPostsSuccessful());
    });
  }

  void setFavPosts(var name, var language,){
    PostsModel model = PostsModel(
      name: name,
      language: language,
      id: '', createdAt: Timestamp.now().toString(),
    );
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('userPosts')
        .add(model.toJson())
        .then((value) {
      name='';
      language='';
      FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('userPosts')
          .doc(value.id)
          .update({
        'id':value.id,
      });
      // getMeals();
      emit(FavPostsSuccessful());
    }).catchError((error){
      print(error.toString());
      emit(FavPostsError(error.toString()));
    });
    emit(FavPostsSuccessful());
  }
  void deleteFavPost(String id) {
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('userPosts')
        .doc(id).delete();
  }

  void getFavPosts() {
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('userPosts')
        .snapshots()
        .listen((event) {
      posts = [];
      for (var element in event.docs) {
        posts.add(PostByAdminModel.fromJson(element.data()));
      }
      emit(GetFavPostsSuccessful());
    });
  }
  void getPosts() {
    FirebaseFirestore.instance
        .collection('postsByAdmin')
        //.orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      for (var element in event.docs) {
        posts.add(PostByAdminModel.fromJson(element.data()));
      }
      emit(GetPostsSuccessful());
    });
  }
  void deletePost(String id) {
    FirebaseFirestore.instance.collection('postsByAdmin').doc(id).delete();
  }
  void setPostByAdmin(){
    PostByAdminModel model = PostByAdminModel(
      name: postController.text,
      language: languagePostController.text,
      id: '', createdAt: Timestamp.now().toString(),
    );
    FirebaseFirestore.instance
        .collection('postsByAdmin')
        .add(model.toJson())
        .then((value) {
      postController.text='';
      languagePostController.text='';
      FirebaseFirestore.instance
          .collection('postsByAdmin')
          .doc(value.id)
          .update({
        'id':value.id,
      });
      // getMeals();
      emit(PostByAdminSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(PostByAdminErroreState(error.toString()));
    });
    emit(PostByAdminSuccessState());
  }
  void getUserData(){
    if(FirebaseAuth.instance.currentUser!.uid.toString() != systemID){
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get().then((value){
        modelProfile=UserModel(
          name : value['name'],
          email :value['email'],
          password : value['password'],
          phone :value['phone'],
          id : value['id'],
          gender: value['gender'],
          age:value['age'],
        );
        emit(ProfileSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(ProfileErrorState(error.toString()));
      });
    }
    emit(ProfileSuccessState());
  }
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(
      LoginChangePasswordVisibilityState(),
    );
  }
  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    emit(
      LoginChangePasswordVisibilityState(),
    );
  }
  void userRegister({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    required String phone,
    required String age,
    required String gender,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      id = FirebaseAuth.instance.currentUser!.uid.toString();
      createUser(
        email: email,
        name: name,
        password: password,
        phone: phone,
        gender: gender,
        age: age,
        uId: value.user!.uid,
        context: context,
      );
      // navigateAndFinish(context, const HomeScreen());
      emit(SignUpSuccessfulState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUpErrorState(error.toString()));
    });
  }
  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String age,
    required String gender,
    required String uId,
    required BuildContext context,
  }) async {
    try {
      UserModel model = UserModel(
        name: name,
        email: email,
        password: password,
        phone: phone,
        age: age,
        gender: gender,
        id: uId,
      );
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('users');
      userRef.doc(uId).set(model.toJson());
      navigateAndFinish(context, CustomNavigationBarScreen());
      emit(SignUpSuccessfulState());
    } catch (e) {
      showToast(text: e.toString(), state: ToastStates.ERROR);
      emit(SignUpCreateErrorState(e.toString()));
    }
    emit(SignUpCreateSuccessState());
  }
  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      id = FirebaseAuth.instance.currentUser!.uid.toString();
      navigateAndFinish(context, CustomNavigationBarScreen());
      emit(LoginSuccessfulState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(LoginErrorState(error.toString()));
    });
  }
  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => LoginPage()));
    });
    print('Logout successfully');
  }
  void getUid() {
    id = FirebaseAuth.instance.currentUser!.uid.toString();
    print(id);
    emit(LoginSuccessfulState());
  }
}
void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
void navigatePop(BuildContext context) {
  Navigator.pop(context);
}
void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) {
      return false;
    },
  );
}
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
