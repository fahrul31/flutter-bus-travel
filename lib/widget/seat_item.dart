import 'package:bus/common/styles.dart';
import 'package:bus/cubit/seat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatItem extends StatelessWidget {
  final String seatLabel;
  final bool isAvailable;
  final String id;
  const SeatItem({
    super.key,
    required this.seatLabel,
    required this.isAvailable,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<SeatCubit>().isSelected(id);

    backgroundColor() {
      if (isAvailable == false) {
        return charcoalGrey;
      } else {
        if (isSelected) {
          return amberYellow;
        } else {
          return Colors.white;
        }
      }
    }

    textColor() {
      if (isAvailable) {
        return charcoalTextStyle.copyWith(fontSize: 12, color: charcoalGrey);
      } else {
        return const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white);
      }
    }

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          context.read<SeatCubit>().selectSeat(id);
        }
      },
      child: SizedBox(
        height: 45,
        width: 45,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              seatLabel,
              style: textColor(),
            ),
          ),
        ),
      ),
    );
  }
}
