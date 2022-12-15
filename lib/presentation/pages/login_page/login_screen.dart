import 'package:clouddisk_login_form/api/request/login_req.dart';
import 'package:clouddisk_login_form/bloc/login/bloc/login_bloc.dart';
import 'package:clouddisk_login_form/components/auth_button.dart';
import 'package:clouddisk_login_form/components/auth_input.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController domainController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    domainController.dispose();
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future pushDialog() {
      return showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green.shade900,
              ),
            ),
          );
        },
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessLoaded) {
          Navigator.pop(context); //pop dialog
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
        if (state is LoginFailLoaded) {
          Navigator.pop(context); //pop dialog
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is LoginLoading) {
          pushDialog();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(color: Colors.lightBlue),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 86, 32, 0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'HANBIRO',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Cloud Disk',
                      style: TextStyle(
                        fontSize: 48,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    AuthInput(
                      domainController: domainController,
                      label: "Domain",
                      icon: Icons.language,
                      keyboardType: TextInputType.name,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AuthInput(
                      domainController: idController,
                      label: "ID",
                      icon: Icons.person,
                      keyboardType: TextInputType.name,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AuthInput(
                      domainController: passwordController,
                      label: "Password",
                      icon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    AuthButton(
                      label: "Log In",
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(ClickedLoginEvent(logInRequest));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
