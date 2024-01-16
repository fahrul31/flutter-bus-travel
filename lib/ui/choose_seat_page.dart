import 'package:bus/common/styles.dart';
import 'package:bus/cubit/seat_cubit.dart';
import 'package:bus/models/destination_model.dart';
import 'package:bus/models/transaction_model.dart';
import 'package:bus/ui/checkout_page.dart';
import 'package:bus/widget/button.dart';
import 'package:bus/widget/seat_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChooseSeatPage extends StatelessWidget {
  final DestinationModel destination;
  const ChooseSeatPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: midnightBlue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.read<SeatCubit>().resetSeat();
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          children: [
            Text(
              destination.busName,
              style: charcoalTextStyle.copyWith(
                fontSize: 22,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
                color: Colors.white,
              ),
            ),
            Text(
              destination.busType,
              style: charcoalTextStyle.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<SeatCubit, List<String>>(
        builder: (context, state) {
          return BottomAppBar(
              elevation: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'IDR ',
                          decimalDigits: 0,
                        ).format(state.length * destination.price),
                        style: charcoalTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: charcoalGrey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                          onTap: () {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            if (state.isNotEmpty) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CheckOutPage(
                                    transaction: TransactionModel(
                                      destination: destination,
                                      amountOfTraveler: state.length,
                                      selectedSeats: state,
                                      grandTotal:
                                          state.length * destination.price,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                      "Anda belum memilih kursi. Silakan pilih kursi terlebih dahulu."),
                                ),
                              );
                            }
                          },
                          child: const CustomButton(height: 50, text: "Bayar")),
                    ),
                  ),
                ],
              ));
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          children: [
                            Divider(thickness: 5, color: charcoalGrey),
                            Text(
                              "Bagian Depan",
                              style: charcoalTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 40,
                  (BuildContext context, int index) {
                    if ((index + 1) % 5 == 3) {
                      return const SizedBox.shrink();
                    } else {
                      int num = (index + 1) % 5 == 0 ? 5 : (index + 1) % 5;
                      String rowLabel =
                          String.fromCharCode('A'.codeUnitAt(0) + (index ~/ 5));

                      int seatNumber = num;
                      switch (num) {
                        case 3:
                          seatNumber = 0;
                        case 4:
                          seatNumber = num - 1;
                        case 5:
                          seatNumber = num - 1;
                      }

                      String seatLabel = '$rowLabel$seatNumber';
                      bool isAvailable =
                          !destination.bookedSeat!.contains(seatLabel);
                      return SeatItem(
                        seatLabel: seatLabel,
                        id: seatLabel,
                        isAvailable: isAvailable,
                      );
                    }
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 25),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // status seat
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text("Tersedia", style: charcoalTextStyle),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: charcoalGrey,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text("Tidak Tersedia",
                                    style: charcoalTextStyle),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: amberYellow,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child:
                                  Text("Pilihanmu", style: charcoalTextStyle),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
