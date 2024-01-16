import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final int noHP;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.noHP,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "noHP": noHP,
      };

  @override
  List<Object?> get props => [id, email, name, noHP];
}
