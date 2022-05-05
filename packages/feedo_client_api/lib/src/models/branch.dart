import 'dart:convert';

import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final int id;
  final String email;
  final String name;
  const Branch({
    required this.id,
    required this.email,
    required this.name,
  });

  Branch copyWith({
    int? id,
    String? email,
    String? name,
  }) {
    return Branch(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch.fromJson(String source) => Branch.fromMap(json.decode(source));

  @override
  String toString() => 'Branch(id: $id, email: $email, name: $name)';

  @override
  List<Object> get props => [id, email, name];
}
