import 'package:bus/common/styles.dart';
import 'package:bus/cubit/auth_cubit.dart';
import 'package:bus/ui/login_page.dart';
import 'package:bus/widget/button.dart';
import 'package:bus/widget/login_option.dart';
import 'package:bus/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const routeName = '/sign_up_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _txtEditName = TextEditingController();
  final _txtEditEmail = TextEditingController();
  final _txtEditNumber = TextEditingController();
  final _txtEditPassword = TextEditingController();

  @override
  void dispose() {
    _txtEditName.dispose();
    _txtEditEmail.dispose();
    _txtEditNumber.dispose();
    _txtEditPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: midnightBlue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Daftar",
          style: charcoalTextStyle.copyWith(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: _txtEditName,
                  visibleIcon: false,
                  hintText: "Nama Lengkap",
                ),
                const SizedBox(height: 22),
                CustomTextFormField(
                  controller: _txtEditEmail,
                  visibleIcon: false,
                  hintText: "Email",
                ),
                const SizedBox(height: 22),
                CustomTextFormField(
                  controller: _txtEditNumber,
                  visibleIcon: false,
                  hintText: "Nomor Handphone",
                ),
                const SizedBox(height: 22),
                CustomTextFormField(
                  controller: _txtEditPassword,
                  visibleIcon: true,
                  hintText: "Password",
                ),
                const SizedBox(height: 41),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamed(context, LoginPage.routeName);
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
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
                        context.read<AuthCubit>().signUp(
                              email: _txtEditEmail.text,
                              password: _txtEditPassword.text,
                              name: _txtEditName.text,
                              noHP: int.parse(_txtEditNumber.text),
                            )
                      },
                      child: const CustomButton(height: 55, text: "Daftar"),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Center(child: Text("Or")),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
