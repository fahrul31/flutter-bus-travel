import "package:equatable/equatable.dart";

class DestinationModel extends Equatable {
  final String id;
  final String busName;
  final String busFrom;
  final String busTo;
  final String busType;
  final List<String>? bookedSeat;
  final String imgUrl;
  final int price;
  final DateTime dateArrival;
  final DateTime dateDeparture;

  DestinationModel({
    required this.id,
    required this.busName,
    required this.busFrom,
    required this.busTo,
    required this.busType,
    required this.bookedSeat,
    required this.imgUrl,
    required this.price,
    required this.dateArrival,
    required this.dateDeparture,
  });

  factory DestinationModel.fromJson(String id, Map<String, dynamic> json) =>
      DestinationModel(
        id: id,
        busName: json["busName"],
        busFrom: json["busFrom"],
        busTo: json["busTo"],
        busType: json["busType"],
        bookedSeat: (json["bookedSeat"] as List?)
                ?.map((seat) => seat.toString())
                .toList() ??
            [],
        imgUrl: json["imgUrl"] ?? '',
        price: json["price"],
        dateArrival: json["dateArrival"].toDate(),
        dateDeparture: json["dateDeparture"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "busName": busName,
        "busFrom": busFrom,
        "busTo": busTo,
        "busType": busType,
        "dateArrival": dateArrival,
        "dateDeparture": dateDeparture,
        "price": price
      };

  @override
  List<Object?> get props => [
        id,
        busName,
        busFrom,
        busTo,
        busType,
        imgUrl,
        price,
        dateArrival,
        dateDeparture,
      ];
}
