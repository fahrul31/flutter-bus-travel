import 'package:bus/common/styles.dart';
import 'package:bus/cubit/auth_cubit.dart';
import 'package:bus/models/user_model.dart';
import 'package:bus/ui/login_page.dart';
import 'package:bus/widget/custom_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({super.key});

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    context.read<AuthCubit>().getCurrentUser(user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[400],
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthSuccess) {
                  UserModel user = state.user;
                  return Stack(
                    children: [
                      //background image
                      SizedBox(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            "assets/furina.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //gradient
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.black.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //content
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 180, left: 30, right: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: charcoalGrey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 21, top: 21, bottom: 21),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.name[0].toUpperCase() +
                                                user.name.substring(1),
                                            style: charcoalTextStyle.copyWith(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            user.email,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "0${user.noHP.toString()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const CustomBox(text: "Butuh bantuan?"),
                            const SizedBox(height: 22),
                            const CustomBox(text: "Tentang Kami"),
                            const SizedBox(height: 22),
                            const CustomBox(text: "FAQ"),
                            const SizedBox(height: 22),
                            const CustomBox(text: "Syarat dan Ketentuan"),
                            const SizedBox(height: 30),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                final scaffoldMessenger =
                                    ScaffoldMessenger.of(context);
                                if (state is AuthFailed) {
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 1),
                                      content: Text(state.error),
                                    ),
                                  );
                                } else if (state is AuthInitial) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      LoginPage.routeName, (route) => false);
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthFailed) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    context.read<AuthCubit>().signOut();
                                  },
                                  child: SizedBox(
                                    height: 55,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: midnightBlue,
                                        border: Border.all(
                                          color: secondGrey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Keluar",
                                        style: charcoalTextStyle.copyWith(
                                            color: amberYellow,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
