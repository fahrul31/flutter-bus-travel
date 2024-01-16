import 'package:bus/ui/home_page.dart';
import 'package:bus/ui/sign_out_page.dart';
import 'package:bus/ui/transaction_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _transactionsText = 'Transactions';
  static const String _settingText = 'Account';

  @override
  void initState() {
    super.initState();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    const HomePage(),
    const TransactionPage(),
    const SignOutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onBottomNavTapped,
        selectedItemColor: const Color(0xffEF6A37),
        currentIndex: _bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: _homeText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: _transactionsText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: _settingText,
          ),
        ],
      ),
    );
  }
}
