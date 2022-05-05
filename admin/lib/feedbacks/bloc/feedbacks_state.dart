part of 'feedbacks_bloc.dart';

@immutable
abstract class FeedbacksState extends Equatable {
  const FeedbacksState();

  @override
  List<Object?> get props => [];
}

class FeedbacksInitial extends FeedbacksState {}

class FeedbacksLoaded extends FeedbacksState {
  final List<Feedbacks> feedbacks;
  const FeedbacksLoaded({this.feedbacks = const []});

  @override
  List<Object?> get props => [feedbacks];
}

class FeedbacksError extends FeedbacksState {}
