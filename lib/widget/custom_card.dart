import 'package:bus/common/styles.dart';
import 'package:bus/models/destination_model.dart';
import 'package:bus/ui/choose_seat_page.dart';
import 'package:bus/widget/button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final DestinationModel destination;
  const CustomCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateFormat formattedTime = DateFormat('HH:mm');
    return SizedBox(
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
                        color: midnightBlue, shape: BoxShape.circle),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        destination.busName,
                        style: midnightBlueTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'IDR ',
                          decimalDigits: 0,
                        ).format(destination.price),
                        style: midnightBlueTextStyle,
                      ),
                    ],
                  ),
                  Divider(color: midnightBlue, thickness: 2),
                  Row(
                    children: [
                      Text(
                        "Waktu : ${formattedTime.format(destination.dateArrival)} - ${formattedTime.format(destination.dateDeparture)}",
                        style: charcoalTextStyle.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: charcoalGrey),
                      ),
                      const Spacer(),
                      Text(
                        destination.busType,
                        style: charcoalTextStyle.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: charcoalGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Asal",
                              style: charcoalTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: charcoalGrey),
                            ),
                            Text(
                              destination.busFrom,
                              style: charcoalTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: charcoalGrey),
                            ),
                            Text(
                              dateFormat.format(destination.dateDeparture),
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
                              dashColor: amberYellow.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tujuan",
                              style: charcoalTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: charcoalGrey),
                            ),
                            Text(
                              destination.busTo,
                              style: charcoalTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: charcoalGrey),
                            ),
                            Text(
                              dateFormat.format(destination.dateArrival),
                              style: charcoalTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: charcoalGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChooseSeatPage(destination: destination),
                          ),
                        );
                      },
                      child: const CustomButton(height: 45, text: "Periksa")),
                ],
              ),
            ),
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
                        color: midnightBlue, shape: BoxShape.circle),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
