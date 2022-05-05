part of 'question_bloc.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionLoaded extends QuestionState {
  final List<Question> questionLoaded;
  const QuestionLoaded([this.questionLoaded = const []]);

  @override
  List<Object> get props => [questionLoaded];
}


class QuestionError extends QuestionState {}
