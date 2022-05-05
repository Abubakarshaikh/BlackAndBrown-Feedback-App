part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent extends Equatable {
  const FilterEvent();
  @override
  List<Object?> get props => [];
}

class FilterLoad extends FilterEvent {}

class FilterUpadateCondition extends FilterEvent {
  final Condition updateCondition;
  const FilterUpadateCondition({required this.updateCondition});

  @override
  List<Object?> get props => [updateCondition];
}

class FilterUpadateBranches extends FilterEvent {
  final Branch updateBranch;
  const FilterUpadateBranches({required this.updateBranch});

  @override
  List<Object?> get props => [updateBranch];
}

class FilterUpdatedDateTimeRange extends FilterEvent {
  final DateTimeRange dateTimeRange;
  const FilterUpdatedDateTimeRange({required this.dateTimeRange});

  @override
  List<Object?> get props => [dateTimeRange];
}

class FilterEmail extends FilterEvent {
  final String email;

  const FilterEmail({required this.email});
  @override
  List<Object?> get props => [email];
}

class FilterFeedbacks extends FilterEvent {
    final List<Feedbacks> feedbacks;

  const FilterFeedbacks({required this.feedbacks});
  @override
  List<Object?> get props => [feedbacks];
}

