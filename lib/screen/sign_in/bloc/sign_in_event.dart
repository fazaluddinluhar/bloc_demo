part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInTextChangedEvent extends SignInEvent {
  final String emailValue;
  final String passwordValue;

  SignInTextChangedEvent(this.emailValue, this.passwordValue);
}

class SignInSubmitEvent extends SignInEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignInSubmitEvent({
    required this.email,
    required this.password,
    required this.context,
  });
}
