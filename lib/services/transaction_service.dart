import 'package:bus/models/transaction_model.dart';
import 'package:bus/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  final CollectionReference _transactionReference =
      FirebaseFirestore.instance.collection("transactions");

  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("users");

  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;

      DocumentSnapshot snapshot = await _userReference.doc(user.uid).get();

      UserModel userData = UserModel(
        id: user.uid,
        email: snapshot['email'],
        name: snapshot['name'],
        noHP: snapshot['noHP'],
      );

      _transactionReference.add({
        'ticketBuyer': userData.toJson(),
        'destination': transaction.destination.toJson(),
        'amountOfTraveler': transaction.amountOfTraveler,
        'selectedSeats': transaction.selectedSeats,
        'grandTotal': transaction.grandTotal,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;

      QuerySnapshot result = await _transactionReference
          .where('ticketBuyer.id', isEqualTo: user.uid)
          .get();

      List<TransactionModel> transactions = result.docs.map(
        (e) {
          return TransactionModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();
      return transactions;
    } catch (e) {
      throw e;
    }
  }
}
