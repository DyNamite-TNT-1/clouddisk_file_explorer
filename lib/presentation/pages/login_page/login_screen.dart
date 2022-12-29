import 'package:clouddisk_login_form/api/requests/login_req.dart';
import 'package:clouddisk_login_form/bloc/login_bloc/login_bloc.dart';
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
  TextEditingController otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    domainController.dispose();
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: size.height,
                decoration: const BoxDecoration(color: Colors.lightBlue),
                child: SingleChildScrollView(
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
                            controller: domainController,
                            label: "Domain",
                            icon: Icons.language,
                            keyboardType: TextInputType.name,
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          AuthInput(
                            controller: idController,
                            label: "ID",
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          AuthInput(
                            controller: passwordController,
                            label: "Password",
                            icon: Icons.lock,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          AuthInput(
                            controller: otpController,
                            label: "OTP",
                            icon: Icons.code,
                            keyboardType: TextInputType.phone,
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 56,
                          ),
                          AuthButton(
                            label: "Log In",
                            onTap: () {
                              // BlocProvider.of<LoginBloc>(context)
                              //     .add(ClickedLoginEvent(logInRequest));
                              logInRequest.code = otpController.text;
                              context
                                  .read<LoginBloc>()
                                  .add(ClickedLoginEvent(logInRequest));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is LoginLoading)
                Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
              if (state is LoginFailLoaded)
                Center(
                  child: Container(
                    color: Colors.amber.shade50,
                    height: 50,
                    width: 100,
                    child: Text(state.error),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
