import 'package:bus/common/styles.dart';
import 'package:bus/cubit/auth_cubit.dart';
import 'package:bus/cubit/destination_cubit.dart';
import 'package:bus/cubit/seat_cubit.dart';
import 'package:bus/cubit/transaction_cubit.dart';
import 'package:bus/ui/login_page.dart';
import 'package:bus/ui/main_page.dart';
import 'package:bus/ui/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => SeatCubit(),
        ),
        BlocProvider(
          create: (context) => DestinationCubit(),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Busser Demo',
        initialRoute: LoginPage.routeName,
        theme: ThemeData(
          splashColor: Colors.transparent,
          textTheme: myTextTheme.apply(
            bodyColor: Colors.white,
          ),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == SignUpPage.routeName) {
            return CupertinoPageRoute(builder: (context) => const SignUpPage());
          }
          return null;
        },
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          MainPage.routeName: (context) => const MainPage(),
        },
      ),
    );
  }
}
