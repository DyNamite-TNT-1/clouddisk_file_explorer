import 'package:clouddisk_login_form/bloc/login_bloc/login_bloc.dart';
import 'package:clouddisk_login_form/bloc/send_file_bloc/send_file_bloc.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/home_page.dart';
import 'package:clouddisk_login_form/presentation/pages/login_page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = LoginBloc();
    final SendFileBloc sendFileBloc = SendFileBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => loginBloc,
        ),
        BlocProvider(
          create: (context) => sendFileBloc,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

// class NavWidget extends StatefulWidget {
//   const NavWidget({super.key});

//   @override
//   State<NavWidget> createState() => _NavWidgetState();
// }

// class _NavWidgetState extends State<NavWidget> {
//   final LoginBloc loginBloc = LoginBloc();
//   final SendFileBloc sendFileBloc = SendFileBloc();
//   bool hasCookie = false;
//   var session = "";
//   var hmailkey = "";
//   Future<void> getCookie() async {
//     session = await prefs.getSession();
//     hmailkey = await prefs.getHmailKey();
//   }

//   @override
//   void initState() {
//     getCookie().then((_) {
//       if (session != "" && hmailkey != "") {
//         setState(() {
//           hasCookie = true;
//         });
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     loginBloc.close();
//     sendFileBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoginBloc loginBloc = LoginBloc();
  final SendFileBloc sendFileBloc = SendFileBloc();
  bool hasCookie = false;
  var session = "";
  var hmailkey = "";
  Future<void> getCookie() async {
    session = await prefs.getSession();
    hmailkey = await prefs.getHmailKey();
  }

  @override
  void initState() {
    getCookie().then((_) {
      if (session != "" && hmailkey != "") {
        setState(() {
          hasCookie = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.close();
    sendFileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasCookie ? const HomePage() : const LoginScreen(),
    );
  }
}
