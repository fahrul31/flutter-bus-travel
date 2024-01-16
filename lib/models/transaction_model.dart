import 'package:bus/models/destination_model.dart';
import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final DestinationModel destination;
  final int amountOfTraveler;
  final List<String> selectedSeats;
  final int grandTotal;

  const TransactionModel({
    this.id = '',
    required this.destination,
    required this.amountOfTraveler,
    required this.selectedSeats,
    required this.grandTotal,
  });

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      TransactionModel(
        id: id,
        destination: DestinationModel.fromJson(
            json["destination"]["id"], json["destination"]),
        amountOfTraveler: json["amountOfTraveler"],
        selectedSeats: (json["selectedSeats"] as List)
            .map((seat) => seat.toString())
            .toList(),
        grandTotal: json["grandTotal"],
      );

  @override
  List<Object?> get props =>
      [destination, amountOfTraveler, selectedSeats, grandTotal];
}
