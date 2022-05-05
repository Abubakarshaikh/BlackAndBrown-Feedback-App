import 'package:admin/filter/filter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:feedo_repository/feedo_repository.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final FirebaseFeedoRepository _firebaseFeedoRepository;
  FilterBloc(this._firebaseFeedoRepository) : super(FilterInitial()) {
    on<FilterLoad>(_onFilterLoad);
    on<FilterUpadateCondition>(_onFilterUpdateCondition);
    on<FilterUpadateBranches>(_onFilterUpdateBranches);
    on<FilterUpdatedDateTimeRange>(_onFilterUpdateDateTimeRange);
    on<FilterEmail>(_onFilterEmail);
  }

  Future<void> _onFilterLoad(
      FilterLoad event, Emitter<FilterState> emit) async {
    emit(FilterInitial());
    try {
      emit(
        FilterLoaded(
          email: "No email given",
          condition: Condition.all,
          branches: await _firebaseFeedoRepository.lodBranches(),
          dateTimeRange: null,
        ),
      );
    } on Exception {
      emit(FilterError());
    }
  }

  void _onFilterUpdateCondition(
      FilterUpadateCondition event, Emitter<FilterState> emit) {
    final state = this.state;
    try {
      if (state is FilterLoaded) {
        emit(FilterLoaded(
            email: state.email,
            condition: event.updateCondition,
            branches: state.branches,
            dateTimeRange: state.dateTimeRange));
      }
    } on Exception {
      emit(FilterError());
    }
  }

  void _onFilterUpdateBranches(
      FilterUpadateBranches event, Emitter<FilterState> emit) {
    final state = this.state;
    try {
      if (state is FilterLoaded) {
        final List<Branch> updatedBranches =
            state.branches.map((Branch branch) {
          return branch.branchName == event.updateBranch.branchName
              ? event.updateBranch
              : branch;
        }).toList();
        emit(FilterLoaded(
            email: state.email,
            condition: state.condition,
            branches: updatedBranches,
            dateTimeRange: state.dateTimeRange));
      }
    } on Exception {
      emit(FilterError());
    }
  }

  void _onFilterUpdateDateTimeRange(
      FilterUpdatedDateTimeRange event, Emitter<FilterState> emit) {
    final state = this.state;
    try {
      print('${event.dateTimeRange}');
      if (state is FilterLoaded) {
        emit(FilterLoaded(
          email: state.email,
          condition: state.condition,
          branches: state.branches,
          dateTimeRange: event.dateTimeRange,
        ));
      }
    } on Exception {
      emit(FilterError());
    }
  }

  void _onFilterEmail(FilterEmail event, Emitter<FilterState> emit) {
    final state = this.state;
    print('----new------${event.email}-----new-----');
    try {
      if (state is FilterLoaded) {
        emit(FilterLoaded(
          email: event.email,
          condition: state.condition,
          branches: state.branches.where((e) {
            final branch = e.branchName.replaceAll(' ', '').toLowerCase();
            final email = event.email.substring(0, event.email.indexOf("@"));
            return branch == email || email == 'admin';
          }).toList(),
          dateTimeRange: state.dateTimeRange,
        ));
      }
    } on Exception {
      emit(FilterError());
    }
  }
}
