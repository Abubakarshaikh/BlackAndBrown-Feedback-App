import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedo_repository/feedo_repository.dart';

class CustomerFeedback {
  final String condition;
  final String branch;
  final String userEmail;
  final DateTime time;
  final String number;
  final String name;
  final String email;
  final List<Question> questions;
  DocumentReference? reference;

  CustomerFeedback({
    this.condition = "Mature",
    required this.branch,
    required this.userEmail,
    required this.time,
    required this.number,
    required this.name,
    required this.email,
    required this.questions,
    this.reference,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'condition': condition,
        'branch': branch,
        'userEmail': userEmail,
        'time': time,
        'number': number,
        'name': name,
        'email': email,
        'questions': questions.map((questions) => questions.toJson()).toList(),
      };

  CustomerFeedback copyWith({
    String? condition,
    String? branch,
    String? userEmail,
    DateTime? time,
    String? number,
    String? name,
    String? email,
    List<Question>? questions,
  }) {
    return CustomerFeedback(
      condition: condition ?? this.condition,
      branch: branch ?? this.branch,
      userEmail: userEmail ?? this.userEmail,
      time: time ?? this.time,
      number: number ?? this.number,
      name: name ?? this.name,
      email: email ?? this.email,
      questions: questions ?? this.questions,
    );
  }
}
