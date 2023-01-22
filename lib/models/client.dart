// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class Client {
  final id = UniqueKey();
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final DateTime? dateOfBirth;
   Client(  [this.name = '', this.lastName = '', this.email = '', this.phone = '',this.dateOfBirth]);

  @override
  String toString() {
    return "Client{id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth}";
  }
}

@immutable
class ClientForPanel extends Client {
  final bool isExpanded;
   ClientForPanel([this.isExpanded = false, super.name, super.lastName, super.email, super.phone, super.dateOfBirth]);
  @override
  String toString() {
    return "ClientForPanel{id: $id, name: $name, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, isExpanded: $isExpanded}";
  }

  ClientForPanel copyWith({
    bool? isExpanded,
  }) {
    return ClientForPanel(
      isExpanded ?? this.isExpanded,
    );
  }
}
