import 'package:bloc_demo/presentation/screens/dashboard_screen.dart';
import 'package:bloc_demo/screen/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscured = true;
  bool isSignInButtonEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          elevation: 5,
          shadowColor: Colors.black,
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                      child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: userEmailController,
                    onChanged: (val) {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInTextChangedEvent(userEmailController.text,
                              passwordController.text));
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    onChanged: (val) {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInTextChangedEvent(userEmailController.text,
                              passwordController.text));
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      //labelText: AppLocalizations.of(context)!.loginPasswordLb,
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: toggleObscured,
                          child: Icon(
                            isObscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    obscureText: isObscured,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state is SignInErrorState) {
                        isSignInButtonEnabled = false;
                      } else if (state is SignInValidState) {
                        isSignInButtonEnabled = true;
                      } else if (state is SignInSuccessState) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) {
                            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
                            //return const HomeScreen();
                            return const DashboardScreen();
                          },
                        ));
                      } else {
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SignInLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return CupertinoButton(
                        //color:
                        //    isSignInButtonEnabled ? Colors.blue : Colors.grey,
                        color: isSignInButtonEnabled
                            ? CupertinoTheme.of(context).primaryColor // Enabled color
                            : CupertinoColors.inactiveGray, // Disabled color
                        child: const Text("Login"),
                        onPressed: () {
                          if (state is SignInErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMsg),
                              ),
                            );
                          } else if (isSignInButtonEnabled) {
                            BlocProvider.of<SignInBloc>(context).add(
                              SignInSubmitEvent(
                                  email: userEmailController.text,
                                  password: passwordController.text,
                                  context: context),
                            );
                          } else {
                            const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleObscured() {
    setState(() {
      isObscured = !isObscured;
    });
  }
}
