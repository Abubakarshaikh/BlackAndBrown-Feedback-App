import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:feedo_repository/feedo_repository.dart';

class FeedbacksEntity extends Equatable {
  final String id;
  final String branch;
  final String condition;
  final DateTime time;
  final String number;
  final String name;
  final String email;
  final List<Question> questions;
  final String userEmail;
  DocumentReference? reference;
  FeedbacksEntity({
    required this.id,
    required this.branch,
    required this.condition,
    required this.time,
    required this.number,
    required this.name,
    required this.email,
    required this.questions,
    required this.userEmail,
    this.reference,
  });

  FeedbacksEntity copyWith({
    String? id,
    String? branch,
    String? condition,
    DateTime? time,
    String? number,
    String? name,
    String? email,
    List<Question>? questions,
    String? userEmail,
    DocumentReference? reference,
  }) {
    return FeedbacksEntity(
      id: id ?? this.id,
      branch: branch ?? this.branch,
      condition: condition ?? this.condition,
      time: time ?? this.time,
      number: number ?? this.number,
      name: name ?? this.name,
      email: email ?? this.email,
      questions: questions ?? this.questions,
      userEmail: userEmail ?? this.userEmail,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'branch': branch,
      'condition': condition,
      'time': time.millisecondsSinceEpoch,
      'number': number,
      'name': name,
      'email': email,
      'questions': questions.map((x) => x.toMap()).toList(),
      'userEmail': userEmail,
    };
  }

  factory FeedbacksEntity.fromMap(Map<String, dynamic> map) {
    return FeedbacksEntity(
      id: map['id'],
      branch: map['branch'],
      condition: map['condition'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      number: map['number'],
      name: map['name'],
      email: map['email'],
      questions: List<Question>.from(
          map['questions'].map((x) => Question.fromMap(x))),
      userEmail: map['userEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbacksEntity.fromJson(String source) =>
      FeedbacksEntity.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      branch,
      condition,
      time,
      number,
      name,
      email,
      questions,
      userEmail,
    ];
  }

  static FeedbacksEntity fromSnapshot(DocumentSnapshot snapshot) {
    final feedback =
        FeedbacksEntity.fromMap(snapshot.data() as Map<String, dynamic>);
    feedback.reference = snapshot.reference;
    return feedback;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch': branch,
      'condition': condition,
      'time': time.millisecondsSinceEpoch,
      'number': number,
      'name': name,
      'email': email,
      'questions': questions.map((x) => x.toMap()).toList(),
      'userEmail': userEmail,
    };
  }
}
