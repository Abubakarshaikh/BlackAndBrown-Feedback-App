part of 'title_bloc.dart';

abstract class TitleState extends Equatable {
  const TitleState();

  @override
  List<Object> get props => [];
}

class TitleInitial extends TitleState {}

class TitleLoaded extends TitleState {
  final int index;
  final List<Question> title;
  const TitleLoaded({required this.title, this.index = 0});
  @override
  List<Object> get props => [title, index];
}

class TitleError extends TitleState {}
