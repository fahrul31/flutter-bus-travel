import 'package:bus/models/destination_model.dart';
import 'package:bus/services/destination_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationInitial());

  void fetchDestinations() async {
    try {
      emit(DestinationLoading());

      List<DestinationModel> destinations =
          await DestinationService().fetchDestinations();

      emit(DestinationSuccess(destinations));
    } catch (e) {
      emit(DestinationFailed(e.toString()));
    }
  }

  void searchDestinations(String origin, String destination,
      String? departureDate, String? arrivalDate) async {
    try {
      emit(DestinationLoading());
      DateFormat dateFormat = DateFormat('dd MMM yyyy');
      List<DestinationModel> searchDestinations =
          await DestinationService().searchDestinations(
        origin: origin,
        destination: destination,
      );

      if (departureDate != null && arrivalDate != null) {
        searchDestinations = searchDestinations.where((destination) {
          return (dateFormat.format(destination.dateArrival) == arrivalDate) &&
              (dateFormat.format(destination.dateDeparture) == departureDate);
        }).toList();
      } else if (departureDate != null) {
        searchDestinations = searchDestinations.where((destination) {
          return (dateFormat.format(destination.dateDeparture) ==
              departureDate);
        }).toList();
      }

      emit(DestinationSuccess(searchDestinations));
    } catch (e) {
      emit(DestinationFailed(e.toString()));
    }
  }

  void bookedDestinations(
      String destinationId, List<String> selectedSeats) async {
    try {
      await DestinationService()
          .updateBookedSeats(destinationId, selectedSeats);
      print('Seats updated successfully.');
    } catch (e) {
      print('Error updating seats: $e');
    }
  }
}
