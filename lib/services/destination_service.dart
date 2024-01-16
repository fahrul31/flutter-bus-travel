import 'package:bus/models/destination_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationService {
  final CollectionReference _destinationReference =
      FirebaseFirestore.instance.collection("destinations");

  Future<List<DestinationModel>> fetchDestinations() async {
    try {
      QuerySnapshot result = await _destinationReference.get();

      List<DestinationModel> destinations = result.docs.map(
        (e) {
          return DestinationModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();
      return destinations;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DestinationModel>> searchDestinations({
    required String origin,
    required String destination,
    DateTime? departureDate,
    DateTime? returnDate,
  }) async {
    try {
      QuerySnapshot result = await _destinationReference
          .where('busFrom', isEqualTo: origin)
          .where('busTo', isEqualTo: destination)
          .get();

      List<DestinationModel> destinations = result.docs.map(
        (e) {
          return DestinationModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();
      return destinations;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateBookedSeats(
      String destinationId, List<String> selectedSeats) async {
    try {
      await _destinationReference.doc(destinationId).update({
        'bookedSeat': FieldValue.arrayUnion(selectedSeats),
      });
    } catch (e) {
      throw e;
    }
  }
}
