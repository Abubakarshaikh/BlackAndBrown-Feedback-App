import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'package:feedo_repository/feedo_repository.dart';

@immutable
class Feedbacks extends Equatable {
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
  Feedbacks({
    String? id,
    required this.branch,
    required this.condition,
    required this.time,
    required this.number,
    required this.name,
    required this.email,
    required this.questions,
    required this.userEmail,
    this.reference,
  }) : id = id ?? Uuid().v4();

  factory Feedbacks.fromSnapshot(DocumentSnapshot snapshot) {
    final feedback = Feedbacks.fromMap(snapshot.data() as Map<String, dynamic>);
    feedback.reference = snapshot.reference;
    return feedback;
  }

  Feedbacks copyWith({
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
    return Feedbacks(
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

  factory Feedbacks.fromMap(Map<String, dynamic> map) {
    return Feedbacks(
      id: map['id'],
      branch: map['branch'],
      condition: map['condition'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      number: map['number'],
      name: map['name'],
      email: map['email'],
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
      userEmail: map['userEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedbacks.fromJson(String source) =>
      Feedbacks.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
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
      reference,
    ];
  }

  FeedbacksEntity toEntity() {
    return FeedbacksEntity(
        id: id,
        branch: branch,
        condition: condition,
        time: time,
        number: number,
        name: name,
        email: email,
        questions: questions,
        userEmail: userEmail);
  }

  static Feedbacks fromEntity(FeedbacksEntity entity) {
    return Feedbacks(
        id: entity.id,
        branch: entity.branch,
        condition: entity.condition,
        time: entity.time,
        number: entity.number,
        name: entity.name,
        email: entity.email,
        questions: entity.questions,
        userEmail: entity.userEmail);
  }
}

class Question extends Equatable {
  final bool isChecked;
  final int quesNum;
  final String ques;
  final String feedback;
  const Question({
    this.isChecked = true,
    required this.quesNum,
    required this.ques,
    this.feedback = "YES",
  });

  Question copyWith({
    bool? isChecked,
    int? quesNum,
    String? ques,
    String? feedback,
  }) {
    return Question(
      isChecked: isChecked ?? this.isChecked,
      quesNum: quesNum ?? this.quesNum,
      ques: ques ?? this.ques,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isChecked': isChecked,
      'quesNum': quesNum,
      'ques': ques,
      'feedback': feedback,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      isChecked: map['isChecked'],
      quesNum: map['quesNum'],
      ques: map['ques'],
      feedback: map['feedback'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [isChecked, quesNum, ques, feedback];
}
