import 'package:bus/common/styles.dart';
import 'package:bus/ui/main_page.dart';
import 'package:bus/widget/button.dart';
import 'package:flutter/material.dart';

class SuccessCheckoutPage extends StatefulWidget {
  const SuccessCheckoutPage({super.key});

  @override
  State<SuccessCheckoutPage> createState() => _SuccessCheckoutPageState();
}

class _SuccessCheckoutPageState extends State<SuccessCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: midnightBlue,
        centerTitle: true,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Selamat',
                            style: charcoalTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: charcoalGrey,
                            ),
                          ),
                          Text(
                            'Pembayaran Tiket Anda',
                            style: charcoalTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: charcoalGrey,
                            ),
                          ),
                          Text(
                            'Berhasil',
                            style: charcoalTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: charcoalGrey,
                            ),
                          ),
                          Icon(
                            Icons.task_alt_outlined,
                            size: MediaQuery.of(context).size.width - 200,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Jumlah Pembayaran',
                            style: charcoalTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: charcoalGrey,
                            ),
                          ),
                          Text(
                            'IDR 450.000',
                            style: charcoalTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: charcoalGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: InkWell(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context, MainPage.routeName, (route) => false),
                          child:
                              const CustomButton(text: "Kembali", height: 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
