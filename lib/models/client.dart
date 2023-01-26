import 'package:flutter/cupertino.dart';

class Client {
  final id = UniqueKey();
  String name;
  String lastName;
  String email;
  String phone;
  DateTime? dateOfBirth;
  Client([this.name = '', this.lastName = '', this.email = '', this.phone = '', this.dateOfBirth]);

  @override
  String toString() {
    return "Client{id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth}";
  }
}

class ClientForPanel extends Client {
  bool isExpanded = false;
  ClientForPanel(this.isExpanded, String name, String lastName, String email, String phone, DateTime dateOfBirth)
      : super(name, lastName, email, phone, dateOfBirth);
  @override
  String toString() {
    return "ClientForPanel{id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, isExpanded: $isExpanded}";
  }
}
