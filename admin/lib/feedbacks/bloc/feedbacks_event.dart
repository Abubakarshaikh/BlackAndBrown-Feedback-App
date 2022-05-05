part of 'feedbacks_bloc.dart';

@immutable
abstract class FeedbacksEvent extends Equatable {
  const FeedbacksEvent();

  @override
  List<Object?> get props => [];
}

class FeedbacksLoad extends FeedbacksEvent {}

class FeedbacksUpdated extends FeedbacksEvent {
  final List<Feedbacks> feedbacks;

  const FeedbacksUpdated(this.feedbacks);

  @override
  List<Object> get props => [feedbacks];
}

class FeedbacksFilter extends FeedbacksEvent {
  final Condition condition;
  final List<Branch> branches;
  final List<DateTime> dateTime;

  const FeedbacksFilter(
      {required this.condition,
      required this.branches,
      required this.dateTime});
}
