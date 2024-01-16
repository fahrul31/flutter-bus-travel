import 'dart:async';

import 'package:bus/common/styles.dart';
import 'package:bus/cubit/auth_cubit.dart';
import 'package:bus/ui/main_page.dart';
import 'package:bus/ui/sign_up_page.dart';
import 'package:bus/widget/button.dart';
import 'package:bus/widget/login_option.dart';
import 'package:bus/widget/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _txtEditEmail = TextEditingController();
  final _txtEditPassword = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.routeName, (route) => false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _txtEditEmail.dispose();
    _txtEditPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset("assets/bus.png"),
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  controller: _txtEditEmail,
                  visibleIcon: false,
                  hintText: "Email",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _txtEditPassword,
                  visibleIcon: true,
                  hintText: "Password",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lupa Password",
                        style: myTextTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainPage.routeName,
                        (route) => false,
                      );
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return InkWell(
                      onTap: () => {
                        context.read<AuthCubit>().signIn(
                              email: _txtEditEmail.text,
                              password: _txtEditPassword.text,
                            )
                      },
                      child: const CustomButton(height: 55, text: "Masuk"),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text("Or"),
                const SizedBox(height: 22),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginOptionsWidget(image: "assets/FB.png"),
                    SizedBox(width: 15),
                    LoginOptionsWidget(image: "assets/Google.png"),
                    SizedBox(width: 15),
                    LoginOptionsWidget(image: "assets/WA.png"),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    SignUpPage.routeName,
                  ),
                  child: Text(
                    "Belum punya akun?",
                    style: myTextTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
