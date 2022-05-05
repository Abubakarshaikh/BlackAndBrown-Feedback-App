part of 'title_bloc.dart';

abstract class TitleEvent extends Equatable {
  const TitleEvent();

  @override
  List<Object> get props => [];
}

class TitleLoad extends TitleEvent {}

class TitleUpdate extends TitleEvent {
  final Question feedback;
  const TitleUpdate({required this.feedback});

  @override
  List<Object> get props => [feedback];
}
