part of 'cubit.dart';

@immutable
abstract class AuthState {}

class ProjectInitial extends AuthState {}

class LoginSuccessfulState extends AuthState{}

class LoginLoadingState extends AuthState{}

class LoginErrorState extends AuthState{
  final String error;
  LoginErrorState(this.error);
}
class SignUpSuccessfulState extends AuthState{}

class SignUpLoadingState extends AuthState{}

class SignUpErrorState extends AuthState{
  final String error;
  SignUpErrorState(this.error);
}

class SignUpCreateSuccessState extends AuthState{}

class SignUpCreateLoadingState extends AuthState{}

class SignUpCreateErrorState extends AuthState{
  final String error;
  SignUpCreateErrorState(this.error);
}
class LoginChangePasswordVisibilityState extends AuthState{}

class ProfileSuccessState extends AuthState{}

class ProfileErrorState extends AuthState{
  final String error;
  ProfileErrorState(this.error);
}

class PostByAdminSuccessState extends AuthState{}

class PostByAdminErroreState extends AuthState{
  final String error;
  PostByAdminErroreState(this.error);
}

class GetPostsSuccessful extends AuthState{}
class FavPostsSuccessful extends AuthState{}
class FavPostsError extends AuthState{
  final String error;
  FavPostsError(this.error);
}
class GetFavPostsSuccessful extends AuthState{}

class SearchPostSucessful extends AuthState{}
class SearchPostError extends AuthState{
  final String error;
  SearchPostError(this.error);
}

class DeletedFavPostSuc extends AuthState{}
