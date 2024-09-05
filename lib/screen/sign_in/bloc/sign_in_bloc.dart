import 'package:bloc_demo/screen/sign_in/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final Dio dio = Dio(); // Create a Dio instance for making API calls

  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (event.emailValue == "") {
        emit(SignInErrorState('Please enter email address'));
      } else if (!isEmailValid(event.emailValue)) {
        emit(SignInErrorState('Please enter valid email address'));
      } else if (event.passwordValue == "") {
        emit(SignInErrorState('Please enter password'));
      } else if (event.passwordValue.length < 7) {
        emit(SignInErrorState(
            'Password is short please enter 7 digit password'));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmitEvent>((event, emit) async {
      emit(SignInLoadingState());

      final context =
          event.context; // Store the context before the asynchronous call

      try {
        final response = await dio.post(
          'http://198.251.74.218/PCAPI/api/v1/authentication',
          data: {
            'Email': "srinath@omexinfotech.com",
            'Password': "sa@1234",
            'FCMToken':
                "f7nldnjwRZm9gpWMS4GVYS:APA91bEtoPFhxtflmIwdO6Uj22BBJN87N4WeELlxjYem_YMhrkkK9s9UHsq80Q06XX4jbFeeuDuOeBJfkd85bSXqaehoTkH1uh727mRzUvrx7IDfuhugiT6tdC1_7OCEPF45wDqLdase",
            'DeviceID': "UE1A.230829.030",
            'IsTermsAndConditionAccept': "true",
            'IsPrivacyPolicyAccept': "true",
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if (response.statusCode == 200) {
          if (response.data['Status'] == "OK") {
            final userData = UserData.fromJson(response.data['data']);
            emit(SignInSuccessState(userData));
            if (context.mounted) {
              showSuccessSnackbar(context, 'Login Successful');
            }
          } else {
            emit(SignInErrorState('API Error: ${response.data['Message']}'));
            if (context.mounted) {
              showErrorSnackbar(
                  context, 'API Error: ${response.data['Message']}');
            }
          }
        } else {
          emit(SignInErrorState('API Error: ${response.statusCode}'));
          if (context.mounted) {
            showErrorSnackbar(context, 'API Error: ${response.statusCode}');
          }
        }
      } catch (error) {
        emit(SignInErrorState('API Error: $error'));
        if (context.mounted) {
          showErrorSnackbar(context, 'API Error: $error');
        }
      }
    });
  }

  void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green, // Set the color to green for success
      ),
    );
  }

  void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red, // Set the color to red for error
      ),
    );
  }

  Future loginAPICall() async {
    try {
      final response = await dio.post(
        'http://198.251.74.218/PCAPI/api/v1/authentication',
        data: {
          'Email': "srinath@omexinfotech.com",
          'Password': "sa@1234",
          'FCMToken':
              "f7nldnjwRZm9gpWMS4GVYS:APA91bEtoPFhxtflmIwdO6Uj22BBJN87N4WeELlxjYem_YMhrkkK9s9UHsq80Q06XX4jbFeeuDuOeBJfkd85bSXqaehoTkH1uh727mRzUvrx7IDfuhugiT6tdC1_7OCEPF45wDqLdase",
          'DeviceID': "UE1A.230829.030",
          'IsTermsAndConditionAccept': "true",
          'IsPrivacyPolicyAccept': "true",
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['Status'] == "OK") {
          //final userData = UserData.fromJson(response.data['data']);
          //emit(SignInSuccessState(userData));
        } else {
          //emit(SignInErrorState('API Error: ${response.data['Message']}'));
        }
      } else {
        //emit(SignInErrorState('API Error: ${response.statusCode}'));
      }
    } catch (error) {
      //emit(SignInErrorState('API Error: $error'));
    }
  }

  bool isEmailValid(String email) {
    // Regular expression for basic email validation
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }
}
