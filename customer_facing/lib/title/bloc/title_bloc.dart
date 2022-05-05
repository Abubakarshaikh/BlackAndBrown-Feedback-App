import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedo_repository/feedo_repository.dart';
part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  FirebaseFeedoRepository firebaseFeedoRepository;
  TitleBloc(this.firebaseFeedoRepository) : super(TitleInitial()) {
    on<TitleLoad>(_titleLoad);
    on<TitleUpdate>(_titleUpdate);
  }

  void _titleLoad(TitleLoad event, Emitter<TitleState> emit) async {
    try {
      emit(TitleLoaded(title: await firebaseFeedoRepository.loadQuestions()));
    } on Exception {
      emit(TitleError());
    }
  }

  void _titleUpdate(TitleUpdate event, Emitter<TitleState> emit) {
    final state = this.state;
    try {
      if (state is TitleLoaded) {
        final _length = state.title.length - 1;
        final updatedIndex =
            state.index != _length ? state.index + 1 : state.index * 0;
        final List<Question> updatesState =
            List.from(state.title.map((Question question) {
          return question.ques == event.feedback.ques
              ? event.feedback
              : question;
        }));

        emit(TitleLoaded(title: updatesState, index: updatedIndex));
      }
    } on Exception {
      emit(TitleError());
    }
  }
}
