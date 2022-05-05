import 'package:admin/filter/filter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:feedo_repository/feedo_repository.dart';
part 'feedbacks_event.dart';
part 'feedbacks_state.dart';

class FeedbacksBloc extends Bloc<FeedbacksEvent, FeedbacksState> {
  final FirebaseFeedoRepository _firebaseFeedoRepository;
  FeedbacksBloc(FirebaseFeedoRepository? firebaseFeedoRepository)
      : _firebaseFeedoRepository =
            firebaseFeedoRepository ?? FirebaseFeedoRepository(),
        super(FeedbacksInitial()) {
    on<FeedbacksLoad>(_onLoadFeedbacks);
    on<FeedbacksUpdated>(_onFeedbacksUpdated);
    on<FeedbacksFilter>(_onFeedbacksFilter);
  }

  Future<void> _onLoadFeedbacks(
      FeedbacksLoad event, Emitter<FeedbacksState> emit) {
    emit(FeedbacksInitial());
    return emit.onEach<List<Feedbacks>>(
      _firebaseFeedoRepository.feedbacks(),
      onData: (feedbacks) => add(FeedbacksUpdated(feedbacks)),
    );
  }

  void _onFeedbacksUpdated(
      FeedbacksUpdated event, Emitter<FeedbacksState> emit) {
    emit(FeedbacksLoaded(feedbacks: event.feedbacks));
  }

  void _onFeedbacksFilter(FeedbacksFilter event, Emitter<FeedbacksState> emit) {
    final state = this.state;
    if (state is FeedbacksLoaded) {
      List<Feedbacks> _feedbacks = state.feedbacks.where((element) {
        String condition = "All";
        condition =
            event.condition == Condition.critical ? "Critical" : "Major";
        return event.condition == Condition.all ||
            condition == element.condition;
      }).where((e) {
        return event.branches.any((j) {
          return j.isChecked == true &&
              (j.branchName.toLowerCase().replaceAll(' ', '') == e.branch);
        });
      }).where((j) {
        if (event.dateTime.isEmpty) return true;
        return event.dateTime.any((t) {
          return j.time
                  .toString()
                  .substring(0, j.time.toString().indexOf(' ')) ==
              t.toString().substring(0, t.toString().indexOf(' '));
        });
      }).toList();
      print('--------${event.dateTime.map((e) => e)}------------');
      emit(FeedbacksLoaded(feedbacks: _feedbacks));
    }
  }
}
