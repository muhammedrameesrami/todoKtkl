import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String password;
  String phone;
String id;
  DocumentReference? reference;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    required this.password,
    this.reference,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String?id,
    DocumentReference? reference,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id??this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'email': email,
      'phone': phone,
      'reference': reference,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']??'',
      name: map['name'] ??"",
      email: map['email']??"",
      phone: map['phone']??"",
      password: map['password'] ?? "",
      reference: map['reference'] ,
    );
  }

}