import 'package:bus/common/styles.dart';
import 'package:bus/cubit/auth_cubit.dart';
import 'package:bus/cubit/destination_cubit.dart';
import 'package:bus/cubit/seat_cubit.dart';
import 'package:bus/cubit/transaction_cubit.dart';
import 'package:bus/models/transaction_model.dart';
import 'package:bus/models/user_model.dart';
import 'package:bus/ui/success_checkout_page.dart';
import 'package:bus/widget/button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckOutPage extends StatefulWidget {
  final TransactionModel transaction;
  const CheckOutPage({super.key, required this.transaction});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    context.read<AuthCubit>().getCurrentUser(user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateFormat formattedTime = DateFormat('HH:mm');

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
                        child: Image.network(
                            widget.transaction.destination.imgUrl,
                            fit: BoxFit.cover),
                      ),
                    ),

                    //content
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 180, left: 20, right: 20),
                      child: SizedBox(
                        height: 540,
                        width: MediaQuery.of(context).size.width,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.transaction.destination.busName,
                                  style: midnightBlueTextStyle,
                                ),
                                Divider(color: midnightBlue, thickness: 2),
                                const SizedBox(height: 11),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Asal",
                                              style: charcoalTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                            Text(
                                              widget.transaction.destination
                                                  .busFrom,
                                              style: charcoalTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                            Text(
                                              dateFormat.format(widget
                                                  .transaction
                                                  .destination
                                                  .dateArrival),
                                              style: charcoalTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            DottedLine(
                                              dashLength: 5,
                                              dashGapLength: 5,
                                              dashColor:
                                                  amberYellow.withOpacity(0.7),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Tujuan",
                                              style: charcoalTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                            Text(
                                              widget.transaction.destination
                                                  .busTo,
                                              style: charcoalTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                            Text(
                                              dateFormat.format(widget
                                                  .transaction
                                                  .destination
                                                  .dateDeparture),
                                              style: charcoalTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nama Penumpang",
                                              style: charcoalTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                            Text(
                                              user.name[0].toUpperCase() +
                                                  user.name.substring(1),
                                              style: charcoalTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: charcoalGrey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Penjemputan",
                                              style: charcoalTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: charcoalGrey),
                                            ),
                                            Text(
                                              "Bus ${widget.transaction.destination.busName}",
                                              style: charcoalTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: charcoalGrey),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Waktu Berangkat - Tiba",
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: charcoalGrey),
                                                ),
                                                Text(
                                                  "${formattedTime.format(widget.transaction.destination.dateArrival)} - ${formattedTime.format(widget.transaction.destination.dateDeparture)}",
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: charcoalGrey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 22),
                                    Expanded(
                                      child: SizedBox(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Nomor Kursi",
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: charcoalGrey),
                                                ),
                                                Text(
                                                  widget
                                                      .transaction.selectedSeats
                                                      .join(", "),
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: charcoalGrey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: charcoalGrey, width: 2),
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          45)),
                                  onPressed: () {},
                                  child: Text(
                                    "Metode Pembayaran",
                                    style: charcoalTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: charcoalGrey),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Tipe Bus: ${widget.transaction.destination.busType}",
                                          style: charcoalTextStyle.copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w300,
                                              color: charcoalGrey),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${widget.transaction.amountOfTraveler} Tiket Bus",
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: charcoalGrey),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'IDR ',
                                                    decimalDigits: 0,
                                                  ).format(widget.transaction
                                                          .destination.price *
                                                      widget.transaction
                                                          .amountOfTraveler),
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: charcoalGrey),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Diskon",
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: charcoalGrey),
                                                ),
                                                Text(
                                                  "Rp.0",
                                                  style: charcoalTextStyle
                                                      .copyWith(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: charcoalGrey),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                DottedLine(
                                  dashLength: 10,
                                  dashGapLength: 5,
                                  dashColor: charcoalGrey,
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total harga :",
                                        style: charcoalTextStyle.copyWith(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                            color: charcoalGrey),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'IDR ',
                                          decimalDigits: 0,
                                        ).format(widget.transaction.grandTotal),
                                        style: charcoalTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: charcoalGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                BlocConsumer<TransactionCubit,
                                    TransactionState>(
                                  listener: (context, state) {
                                    if (state is TransactionSuccess) {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const SuccessCheckoutPage(),
                                        ),
                                      );
                                    } else if (state is TransactionFailed) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(state.error),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is TransactionLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return InkWell(
                                      onTap: () {
                                        context
                                            .read<TransactionCubit>()
                                            .createTransaction(
                                                widget.transaction);

                                        context
                                            .read<DestinationCubit>()
                                            .bookedDestinations(
                                              widget.transaction.destination.id,
                                              widget.transaction.selectedSeats,
                                            );

                                        context.read<SeatCubit>().resetSeat();
                                      },
                                      child: const CustomButton(
                                          text: "Bayar Tiket", height: 45),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      )),
    );
  }
}
