part of 'filter_bloc.dart';

@immutable
abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

class FilterInitial extends FilterState {}

class FilterFeedbacksLoaded extends FilterState {
  final List<Feedbacks> feedbacks;

  const FilterFeedbacksLoaded({required this.feedbacks});
  @override
  List<Object?> get props => [feedbacks];
}

class FilterLoaded extends FilterState {
  final DateTimeRange? dateTimeRange;
  final Condition condition;
  final List<Branch> branches;
  final String email;
  const FilterLoaded({
    required this.condition,
    required this.branches,
   this.dateTimeRange,
    required this.email,
  });

  @override
  List<Object?> get props =>
      [condition, branches, dateTimeRange, email];
}

class FilterError extends FilterState {}
