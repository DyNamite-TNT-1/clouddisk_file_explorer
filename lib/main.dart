import 'package:clouddisk_login_form/bloc/login/bloc/login_bloc.dart';
import 'package:clouddisk_login_form/models/item.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/home_page.dart';
import 'package:clouddisk_login_form/presentation/pages/login_page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  fakeData();
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
        primarySwatch: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => loginBloc,
        child: const LoginScreen(),
      ),
    );
  }
}
