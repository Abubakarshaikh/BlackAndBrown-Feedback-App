import 'dart:convert';

import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int id;
  final String branchId;
  final String name;
  final String number;
  const Customer({
    required this.id,
    required this.branchId,
    required this.name,
    required this.number,
  });

  Customer copyWith({
    int? id,
    String? branchId,
    String? name,
    String? number,
  }) {
    return Customer(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branchId': branchId,
      'name': name,
      'number': number,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id']?.toInt() ?? 0,
      branchId: map['branchId'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, branchId: $branchId, name: $name, number: $number)';
  }

  @override
  List<Object> get props => [id, branchId, name, number];
}
