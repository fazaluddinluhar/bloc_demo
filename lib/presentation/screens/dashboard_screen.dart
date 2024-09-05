import 'package:bloc_demo/data/models/dashboard_model.dart';
import 'package:bloc_demo/logic/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:bloc_demo/logout_dialog.dart';
import 'package:bloc_demo/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
              //perfValue(false);

              //Navigator.of(context).pushAndRemoveUntil(
              //    MaterialPageRoute(builder: (context) => const SignInScreen()),
              //    (Route<dynamic> route) => false);

              showLogoutDialog(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => DashboardCubit(),
          child: BlocConsumer<DashboardCubit, DashboardState>(
            listener: (context, state) {
              if (state is DashboardErrorState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              if (state is DashboardLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is DashboardLoadedState) {
                return buildPostListView(state.posts);
              }

              return const Center(
                child: Text("An error occured!"),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildPostListView(List<DashboardModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        DashboardModel post = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          elevation: 5,
          child: ListTile(
            title: Text(
              "Title : ${post.title.toString()}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Description : ${post.body.toString()}",
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal)),
          ),
        );
      },
    );
  }

  void showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog();
      },
    );
  }
}
