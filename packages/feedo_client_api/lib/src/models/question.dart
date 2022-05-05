import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int id;
  final String question;
  const Question({
    required this.id,
    required this.question,
  });

  Question copyWith({
    int? id,
    String? question,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      question: map['question'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() => 'Question(id: $id, question: $question)';

  @override
  List<Object> get props => [id, question];
}
