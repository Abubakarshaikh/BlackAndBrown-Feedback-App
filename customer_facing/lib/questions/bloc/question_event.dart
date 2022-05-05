part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class QuestionLoad extends QuestionEvent {}

class QuestionUpdate extends QuestionEvent {
  final Question updatedQuestion;
  const QuestionUpdate({required this.updatedQuestion});

  @override
  List<Object> get props => [updatedQuestion];
}
