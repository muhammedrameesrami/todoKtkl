import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String password;
  String phone;

  DocumentReference? reference;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.reference,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    DocumentReference? reference,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'reference': reference,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ??"",
      email: map['email']??"",
      phone: map['phone']??"",
      password: map['password'] ?? "",
      reference: map['reference'] ,
    );
  }

}