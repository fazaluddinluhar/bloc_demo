import 'package:bloc_demo/presentation/screens/dashboard_screen.dart';
import 'package:bloc_demo/screen/home/home_screen.dart';
import 'package:bloc_demo/screen/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_demo/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogin = await perfValue();
  runApp(MyApp(isLogin: isLogin));
}

Future<bool> perfValue() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLogin') ??
      false; // Return the value, default to false if null
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({super.key, required this.isLogin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.tealAccent,
            colorScheme: const ColorScheme.light(primary: Colors.tealAccent),
            //colorScheme: const ColorScheme.light(primary: Colors.tealAccent,surface: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.white),
        darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.tealAccent,
            colorScheme: const ColorScheme.dark(primary: Colors.tealAccent),
            //colorScheme: const ColorScheme.light(primary: Colors.tealAccent,surface: Colors.black),
            scaffoldBackgroundColor: Colors.black,
            cardColor: Colors.black),
        themeMode: ThemeMode.system,
        //home: isLogin ? const HomeScreen() : const SignInScreen(),
        home: isLogin ? const DashboardScreen() : const SignInScreen(),
      ),
    );
  }
}
