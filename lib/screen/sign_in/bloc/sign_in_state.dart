part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInInValidState extends SignInState {
  final String errorMsg;

  SignInInValidState(this.errorMsg);
}

class SignInValidState extends SignInState {}

class SignInErrorState extends SignInState {
  final String errorMsg;

  SignInErrorState(this.errorMsg);
}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final UserData user;

  SignInSuccessState(this.user);
}
