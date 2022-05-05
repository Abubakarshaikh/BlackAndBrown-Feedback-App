import 'dart:convert';

import 'package:equatable/equatable.dart';

class Feedback extends Equatable {
  final int id;
  final int branchId;
  final int customerId;
  final int questionId;
  final String feedback;
  const Feedback({
    required this.id,
    required this.branchId,
    required this.customerId,
    required this.questionId,
    required this.feedback,
  });

  Feedback copyWith({
    int? id,
    int? branchId,
    int? customerId,
    int? questionId,
    String? feedback,
  }) {
    return Feedback(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      customerId: customerId ?? this.customerId,
      questionId: questionId ?? this.questionId,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branchId': branchId,
      'customerId': customerId,
      'questionId': questionId,
      'feedback': feedback,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      id: map['id']?.toInt() ?? 0,
      branchId: map['branchId']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      questionId: map['questionId']?.toInt() ?? 0,
      feedback: map['feedback'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Feedback(id: $id, branchId: $branchId, customerId: $customerId, questionId: $questionId, feedback: $feedback)';
  }

  @override
  List<Object> get props {
    return [
      id,
      branchId,
      customerId,
      questionId,
      feedback,
    ];
  }
}
