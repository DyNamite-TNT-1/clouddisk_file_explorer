import 'package:clouddisk_login_form/components/auth_button.dart';
import 'package:clouddisk_login_form/components/auth_input.dart';
import 'package:clouddisk_login_form/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
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
              AuthButton(
                label: "Log in",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return const HomePage();
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
