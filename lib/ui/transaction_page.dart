import 'package:bus/common/styles.dart';
import 'package:bus/cubit/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midnightBlue,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TransactionSuccess) {
            if (state.transactions.isEmpty) {
              return const Center(
                child: Text(
                  "Kamu belum memiliki transaksi",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  String bookedSeats =
                      state.transactions[index].selectedSeats.join(", ");
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: SizedBox(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: -20,
                              top: 85,
                              bottom: 85,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: midnightBlue,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              bookedSeats,
                              style: const TextStyle(color: Colors.black),
                            )),
                            Positioned(
                              right: -20,
                              top: 90,
                              bottom: 90,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: midnightBlue,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is TransactionFailed) {
            return Center(
              child: Text(state.error),
            );
          }

          return const Center(
            child: Text("data"),
          );
        },
      ),
    );
  }
}
