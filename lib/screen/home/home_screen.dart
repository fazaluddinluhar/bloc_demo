//import 'package:bloc_demo/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_demo/cubits/internet_cubit.dart';
import 'package:bloc_demo/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    perfValue(true);
  }

  perfValue(bool isLoginValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', isLoginValue);
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocProvider<InternetBloc>(
            create: (context) => InternetBloc(), // Create your InternetBloc here
            child: BlocConsumer<InternetBloc, InternetState>(
              listener: (context, state) {
                if (state is InternetGainedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Internet Connected!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is InternetLostState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Not Internet Connected!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is InternetGainedState) {
                  return const Text("Connected");
                } else if (state is InternetLostState) {
                  return const Text("Not Connected");
                } else {
                  return const Text("Loading");
                }
              },
            ),
          ),
        ),
      ),
    );*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text(
          'Home',
          style: TextStyle(
              //color: Colors.black,
              //fontSize: 20.0,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              perfValue(false);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (Route<dynamic> route) => false);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: BlocProvider(
            create: (context) => InternetCubit(),
            child: BlocConsumer<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state == InternetState.gained) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Internet Connected!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state == InternetState.gained) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Not Internet Connected!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state == InternetState.gained) {
                  return const Text("Connected");
                } else if (state == InternetState.lost) {
                  return const Text("Not Connected");
                } else {
                  return const Text("Loading");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
