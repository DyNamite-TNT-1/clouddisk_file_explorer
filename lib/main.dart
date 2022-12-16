import 'package:clouddisk_login_form/bloc/folder_tree_bloc/bloc/folder_tree_bloc.dart';
import 'package:clouddisk_login_form/bloc/login/bloc/login_bloc.dart';
import 'package:clouddisk_login_form/models/user.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/home_page.dart';
import 'package:clouddisk_login_form/presentation/pages/login_page/login_screen.dart';
import 'package:clouddisk_login_form/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UserPreferences prefs = UserPreferences();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoginBloc loginBloc = LoginBloc();
  bool hasCookie = true;
  var session = "";
  var hmailkey = "";
  Future getCookie() async {
    await prefs.getSession().then((value) {
      session = value;
    });
    await prefs.getHmailKey().then((value) {
      hmailkey = value;
    });
  }

  @override
  void initState() {
    getCookie().then((value) {
      setState(() {
        hasCookie = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (session == "" || hmailkey == "") {
      hasCookie = false;
    } else {
      user.session = session;
      user.hmailKey = hmailkey;
    }
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => loginBloc,
          ),
          BlocProvider(
            create: (context) => FolderTreeBloc(),
          ),
        ],
        child: hasCookie ? const HomePage() : const LoginScreen(),
      ),
    );
  }
}
